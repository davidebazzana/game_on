class Game < ApplicationRecord
  belongs_to :user
  has_many :reviews
  # Enable file attachments
  has_many_attached :files
  
  acts_as_votable
  # Before creating or updating a Game object, check if the title is provided
  validates :title, presence: true

  # Scan files for viruses before saving them
  before_create :scan_for_viruses

  SORTING_CRITERIA = ['Alphabetic', 'Newest', 'Hottest']
  
  def self.search(search)
    byebug
    if search.empty? || search[:sort].eql?('Any')
      return Game.all
    elsif search[:sort] == SORTING_CRITERIA[0]
      byebug
      query = SORT_BY_ALPHA
    elsif search[:sort] == SORTING_CRITERIA[1]
      byebug
      query = SORT_BY_NEWEST
    elsif search[:sort] == SORTING_CRITERIA[2]
      byebug
      query = SORT_BY_LIKES
    end
    self.find_by_sql(query)
  end
  
  private

  SORT_BY_ALPHA = "SELECT * FROM games ORDER BY games.title"

  SORT_BY_NEWEST = "SELECT * FROM games ORDER BY games.created_at DESC"
  
  SORT_BY_LIKES = "SELECT * FROM games ORDER BY cached_votes_score DESC"
  
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
