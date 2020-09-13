class Game < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  # Enable file attachments
  has_many_attached :files
  
  acts_as_votable
  # Before creating or updating a Game object, check if the title is provided
  validates :title, presence: true

  # Scan files for viruses before saving them
  before_create :scan_for_viruses
  before_update :scan_for_viruses

  CATEGORIES = ["Action", "Adventure", "Casual", "Indie", "Racing", "RPG", "Simulation", "Sports", "Strategy", "Other"]

  SORTING_CRITERIA = {"Alphabetic" => " ORDER BY title",
                      "Newest" => " ORDER BY created_at DESC",
                      "Hottest" => " ORDER BY cached_votes_score DESC",
                      "Controversial" => " ORDER BY IFNULL((CAST((cached_votes_total - ABS(cached_votes_score)) AS FLOAT))/cached_votes_total, 0.0) DESC"}

  validates :category, inclusion: { in: CATEGORIES }

  def input_handler(params)
    # regex taken from semver.org
    semver = /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$/

    if (!params[:version].empty? && !semver.match?(params[:version]))
      raise ArgumentError, "invalid version number (visit semver.org for reference and examples)"
    end
    if !params[:files].nil? && params[:files].length() != 5
      raise ArgumentError, "provide 0 or 5 files"
    end
  end

  def self.build_file(file_name, game_id)
    if file_name != nil && game_id != nil
      game = Game.find(game_id)
      game.files.each do |file|
        if file.filename == file_name || file_name == "json" && file.filename.to_s.include?(".json")
          return file
        end
      end
    end
    raise IOError
  end
  
  def self.search(search)

    # QUERY:
    #
    # WITH search_query AS (
    #
    #   SELECT *
    #   FROM games
    #   WHERE title LIKE '%#{word_000}%' AND category = '#{search[:category]}'
    #
    #   UNION
    #
    #   SELECT *
    #   FROM games
    #   WHERE title LIKE '%#{word_001}%' AND category = '#{search[:category]}'
    #
    #   UNION
    #
    #   ad libitum... (the number of unions will depend on the number of words in the name searched)
    #
    # )
    #
    # SELECT *
    # FROM search_query
    # ORDER BY ... (sorting criteria)

    query = "WITH search_query AS ("
    if search[:title].empty?
      if search[:category].eql?("Any")
        query += "SELECT * FROM games"
      else
        query += "SELECT * FROM games WHERE category = '#{search[:category]}'"
      end
    else
      words = search[:title].scan(/[\w']+/)
      
      query += "SELECT * FROM games WHERE title LIKE '%#{words[0]}%'"
      
      query += " AND category = '#{search[:category]}'" if !search[:category].eql?("Any")
      
      words.drop(1).each do |word|
        query += " UNION SELECT * FROM games WHERE title LIKE '%#{word}%'"
        query += " AND category = '#{search[:category]}'" if !search[:category].eql?("Any")
      end
    end
    query += ") SELECT * FROM search_query"
    query += SORTING_CRITERIA[search[:sorting_criterion]] if !search[:sorting_criterion].eql?("Any")
    self.find_by_sql(query)
  end

  def self.favorited_by(user)
    favorites = user.favorite_games
    favorites.find(favorited: self) != nil
  end

  private
  
  def scan_for_viruses
    self.files.each do |file|
      path = ActiveStorage::Blob.service.send(:path_for, file.key)
      unless Clamby.safe?(path)
        File.delete(path)
        raise SecurityError, "A virus has been found on #{file.filename}, upload aborted."
      end
    end
  end

end
