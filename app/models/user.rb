class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #devise :omniauthable, omniauth_providers: %i[facebook]
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :posts
  has_many :likes


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.name = auth.info.name
      user.uid = auth.uid
      user.email = auth.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end


end
