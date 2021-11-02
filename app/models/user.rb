class User < ApplicationRecord
  validates :first_name, presence: true, length: {minimum: 2}
  validates :last_name, presence: true, length: {minimum: 2}
  validates :description, presence: true, length: {maximum: 300}
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 13 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  belongs_to :city
  has_many :gossips

  has_many :sent_messages, foreign_key: 'sender', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient', class_name: "PrivateMessage"

  has_many :comments
  has_many :likes
end
