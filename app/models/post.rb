class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :prefecture_code, presence: true
  validates :rest_type, presence: true
  validate :validate_image
  has_one_attached :image
  include ImageValidators

  belongs_to :user
  belongs_to :community
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  include JpPrefecture
  jp_prefecture :prefecture_code
end
