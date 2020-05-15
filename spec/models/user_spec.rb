require 'rails_helper'

RSpec.describe User, type: :model do
  # ユーザID,メール,パスワードがあれば有効な状態であること
  it "is valid with a user_id, email and password" do
    user = User.new(
      user_id: "taro",
      email: "taro@example.com",
      password: "iamtaroyamada"
    )
    expect(user).to be_valid
  end
  # ユーザIDがなければ無効な状態であること
  it "is invalid without a user_id" do
    user = User.new(user_id: nil)
    user.valid?
    expect(user.errors[:user_id]).to include("を入力してください")
  end
  # メールがなければ無効な状態であること
  it "is invalid without a email"
  # 重複したユーザIDなら無効な状態であること
  it "is invalid with a duplicate user_id"
  # 重複したメールなら無効な状態であること
  it "is invalid with a duplicate email"



end
