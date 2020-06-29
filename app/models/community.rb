class Community < ApplicationRecord
    validates  :name, uniqueness: { scope: :create_user_id}
    belongs_to :create_user, class_name: "User"
    has_many :posts, dependent: :destroy
    has_many :belongings, dependent: :destroy
    has_many :applies, dependent: :destroy
    has_one_attached :image

end
