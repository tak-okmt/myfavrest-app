class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:email]
  validates :email, presence: true, uniqueness: true
  validates :username, length: { maximum: 30 }
  validate :image_type, if: :was_attached?
  has_one_attached :image

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments , dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  private

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