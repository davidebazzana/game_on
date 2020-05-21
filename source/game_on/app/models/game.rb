class Game < ApplicationRecord
  # Enable file attachments
  has_many_attached :files
  
  # Before creating or updating a Game object, check if the title is provided
  validates :title, presence: true
end
