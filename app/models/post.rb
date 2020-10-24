class Post < ApplicationRecord
    validates :title, presence: true, length: { maximum:30 }
    validates :description, presence: true, length: { maximum:200 }
    validates :prefecture_code, presence: true
    validates :rest_type, presence: true
    validate :validate_title_not_including_comma
    has_one_attached :image

    belongs_to :user
    belongs_to :community
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy

    include JpPrefecture
    jp_prefecture :prefecture_code

    private

        def validate_title_not_including_comma
            errors.add(:title, 'にカンマを含めることはできません') if title&.include?(',')
        end
end
