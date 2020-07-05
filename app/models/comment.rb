class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :comments_count
  has_one_attached :image
end
