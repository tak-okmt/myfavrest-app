class Comment < ApplicationRecord
  validates :score, presence: true
  validates :content, presence: true
  validates :visitday, presence: true
  
  belongs_to :user
  belongs_to :post, counter_cache: :comments_count
  has_one_attached :image
end
