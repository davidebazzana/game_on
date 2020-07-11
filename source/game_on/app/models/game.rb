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

  CATEGORIES = ['Action', 'Adventure', 'Casual', 'Indie', 'Racing', 'RPG', 'Simulation', 'Sports', 'Strategy', 'Other']

  validates :category, inclusion: { in: CATEGORIES }

  def self.search(search)
    if search.empty?
      Game.all
    else
      query = "SELECT * FROM games WHERE category = '#{search[:category]}'"
      self.find_by_sql(query)
    end
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
