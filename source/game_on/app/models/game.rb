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

  def self.search(search)
    if search.empty?
      Game.all
    elsif "alpha".in?(search[:sort])
      byebug
      Game.all
    elsif "time".in?(search[:sort])
      byebug
      Game.all
    elsif "like".in?(search[:sort])
      byebug
      query = SORT_BY_LIKES
      self.find_by_sql(query)
    end
  end
  
  private

  SORT_BY_LIKES = "WITH
GamesLikesDislikes AS ( SELECT games.id AS id, votes.vote_flag AS flag, count(*) AS numLikesDislikes FROM games JOIN votes WHERE games.id = votes.votable_id GROUP BY games.id, votes.vote_flag ),
GamesLikes AS ( SELECT * FROM GamesLikesDislikes WHERE flag = 1 ),
GamesDislikes AS ( SELECT * FROM GamesLikesDislikes WHERE flag = 0 ),
GamesTotLikesDislikes AS (
  SELECT GamesLikes.id AS id, GamesLikes.numLikesDislikes AS likes, IFNULL(GamesDislikes.numLikesDislikes, 0) AS dislikes
  FROM GamesLikes LEFT JOIN GamesDislikes ON GamesLikes.id = GamesDislikes.id

  UNION

  SELECT GamesDislikes.id AS id, IFNULL(GamesLikes.numLikesDislikes, 0) AS likes, GamesDislikes.numLikesDislikes AS dislikes
  FROM GamesDislikes LEFT JOIN GamesLikes ON GamesLikes.id = GamesDislikes.id
),
GamesDiffLikesDislikes AS (
  SELECT GamesTotLikesDislikes.id AS id, (GamesTotLikesDislikes.likes - GamesTotLikesDislikes.dislikes) AS totLikes
  FROM GamesTotLikesDislikes
),
GamesNotVoted AS (
  SELECT games.id
  FROM games

  EXCEPT

  SELECT GamesDiffLikesDislikes.id
  FROM GamesDiffLikesDislikes
),
GamesTotalOrdered AS (
  SELECT *
  FROM GamesDiffLikesDislikes

  UNION

  SELECT GamesNotVoted.id, 0
  FROM GamesNotVoted
)

SELECT games.id, games.title, games.info, games.user_id
FROM GamesTotalOrdered JOIN games
WHERE games.id = GamesTotalOrdered.id
ORDER BY GamesTotalOrdered.totLikes DESC"
  
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
