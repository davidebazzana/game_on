class Game < ApplicationRecord
  # Enable file attachment
  has_one_attached :zip
  has_many_attached :files
  
  # Before creating or updating a Game object, check if the title is provided
  validates :title, presence: true
end
