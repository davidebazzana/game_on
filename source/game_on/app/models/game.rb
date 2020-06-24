class Game < ApplicationRecord
  has_many :reviews
  # Enable file attachments
  has_many_attached :files
  
  acts_as_votable
  # Before creating or updating a Game object, check if the title is provided
  validates :title, presence: true

  # Scan files for viruses before saving them
  before_create :scan_for_viruses
  
  private

  def scan_for_viruses
    self.files.each do |file|
      path = ActiveStorage::Blob.service.send(:path_for, file.key)
      unless Clamby.safe?(path)
        File.delete(path)
        raise SecurityError, "A virus on #{file.filename} has been found, uploading aborted."
      end
    end
  end
end
