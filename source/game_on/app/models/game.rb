class Game < ApplicationRecord
  belongs_to :user
  has_many :reviews
  # Enable file attachments
  has_many_attached :files
  
  acts_as_votable
  # Before creating or updating a Game object, check if the title is provided
  validates :title, presence: true
end
