class Gossip < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5, maximum: 900}

  belongs_to :user
  has_many :taggers
  has_many :tags, through: :taggers
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
end
