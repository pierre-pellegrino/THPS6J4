class Gossip < ApplicationRecord
  belongs_to :user
  has_many :taggers
  has_many :tags, through: :taggers
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
end
