class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :prefecture_code, presence: true
  validates :rest_type, presence: true
  validate :validate_icon
  has_one_attached :image

  belongs_to :user
  belongs_to :community
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  include JpPrefecture
  jp_prefecture :prefecture_code

  private

  # アップロード画像のサイズ・拡張子を検証する
  def validate_icon
    return unless image.attached?
    if image.blob.byte_size > 5.megabytes
      image.purge
      errors.add(:image, "は5MB以下にする必要があります")
    elsif !image?
      image.purge
      errors.add(:image, "ファイル拡張子が適切ではありません")
    end
  end

  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(image.blob.content_type)
  end

end
