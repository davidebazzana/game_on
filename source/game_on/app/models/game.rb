class Game < ApplicationRecord
  # Enable file attachment
  has_one_attached :game_file
  
  acts_as_votable
  # Before creating or updating a Game object, check if the title is provided
  validates :title, presence: true
end
