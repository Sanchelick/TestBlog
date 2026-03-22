class Tag < ApplicationRecord
  has_many :article_tags, dependent: :destroy
  has_many :article, through: :article_tags
end
