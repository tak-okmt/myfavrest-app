module ImageValidators
  extend ActiveSupport::Concern

  included do
    validate :validate_image

    # アップロード画像のサイズ・拡張子を検証する
    def validate_image
      return unless image.attached?

      if image.blob.byte_size > 1.megabytes
        image.purge
        errors.add(:image, "は1MB以下にする必要があります")
      elsif !image?
        image.purge
        errors.add(:image, "ファイル拡張子が適切ではありません")
      end
    end

    # ファイル拡張子が画像ファイルかを判定する
    def image?
      %w[image/jpg image/jpeg image/gif image/png].include?(image.blob.content_type)
    end
  end
end
