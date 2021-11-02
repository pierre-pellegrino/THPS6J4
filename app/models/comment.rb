class Comment < ApplicationRecord
  validates :content, presence: true, length: {minimum: 1, maximum: 300}

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
end
