class Article < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  validates :title, length: {minimum: 5, maximum: 50}
  validates :body, length: {minimum: 10, maximum: 200}

  has_many_attached :pictures

  scope :all_by_tags, ->(tag_ids) do
    articles = includes(:user, :article_tags, :tags)
    articles = articles.joins(:tags).where(tags: tag_ids) if tag_ids
    articles.order(created_at: :desc)
  end

  def self.ransackable_associations(auth_object = nil)
    %w[article]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title body]
  end

  
end
