class User < ApplicationRecord

# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable, :lockable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :github]

  acts_as_voter
  has_many :games, dependent: :destroy
  has_many :reviews

  ROLES = %i[admin moderator player]

  has_many :favorites
  has_many :favorite_games, through: :favorites, source: :favorited, source_type: 'Game'

  
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, foreign_key: :followed_id, class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships

  def follows?(other_user)
    following.include?(other_user)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).or(where(email: auth.info.email)).first_or_create do |user|
      user.provider ||= auth.provider
      user.uid ||= auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
      user.role ||= :player

    end
  end
end
