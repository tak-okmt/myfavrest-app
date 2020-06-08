class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one_attached :image
end
