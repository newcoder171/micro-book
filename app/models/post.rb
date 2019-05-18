class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  had_many :likes, as: :likeable
end
