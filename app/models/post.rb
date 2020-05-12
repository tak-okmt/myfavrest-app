class Post < ApplicationRecord
    validates :title, presence: true, length: { maximum:30 }
    validate  :validate_title_not_including_comma
    after_validation :geocode

    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    mount_uploader :image, ImageUploader

    include JpPrefecture
    jp_prefecture :prefecture_code

    private

        def validate_title_not_including_comma
            errors.add(:title, 'にカンマを含めることはできません') if title&.include?(',')
        end

        def geocode
            uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key="+ENV['GMAPS_API_KEY'])
            res = HTTP.get(uri).to_s
            response = JSON.parse(res)
            self.latitude = response["results"][0]["geometry"]["location"]["lat"]
            self.longitude = response["results"][0]["geometry"]["location"]["lng"]
          end
end
