class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:user_id]
  validates :user_id, presence: true, uniqueness: true, length: { in: 3..30 }
  validates :username, presence: true, length: { in: 3..30 }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
end
