class Community < ApplicationRecord
    validates  :name, uniqueness: { scope: :create_user_id }, presence: true, length: { maximum:20 }
    validates :description, length: { maximum:50 }

    belongs_to :create_user, class_name: "User"
    has_many :posts, dependent: :destroy
    has_many :belongings, dependent: :destroy
    has_many :applies, dependent: :destroy
    has_one_attached :image

    has_many :users, through: :belongings # コミュニティに所属しているユーザ

    # ユーザがコミュニティに所属していればtrueを返す
    def user_belonging?(user)
      users.include?(user)
    end

end
