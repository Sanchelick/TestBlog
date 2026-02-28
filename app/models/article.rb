class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, length: {minimum: 5, maximum: 50}
  validates :body, length: {minimum: 10, maximum: 200} 
end
