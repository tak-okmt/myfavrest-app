class Post < ApplicationRecord
    validates :title, presence: true, length: { maximum:30 }, uniqueness: { scope: :user_id }
    validate :validate_title_not_including_comma
    validate :image_type, if: :was_attached?
    has_one_attached :image

    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    include JpPrefecture
    jp_prefecture :prefecture_code

    private

        def validate_title_not_including_comma
            errors.add(:title, 'にカンマを含めることはできません') if title&.include?(',')
        end

        def image_type
            if !image.content_type.in?(%('image/jpec image/png'))
                errors.add(:image, 'JPEGまたはPNG形式の画像のみアップロードできます')
            end
        end

        # not to do the validation of image_type when the registered post don't have the image.
        def was_attached?
            image.attached?
        end
end
