require 'rails_helper'

RSpec.describe User, type: :model do
  # ユーザID,メール,パスワードがあれば有効な状態であること
  it "is valid with a user_id, email and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
  # ユーザIDがなければ無効な状態であること
  it "is invalid without a user_id" do
    user = FactoryBot.build(:user, user_id: nil)
    user.valid?
    expect(user.errors[:user_id]).to include("を入力してください")
  end
  # メールがなければ無効な状態であること
  it "is invalid without a email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")    
  end
  # 重複したユーザIDなら無効な状態であること
  it "is invalid with a duplicate user_id" do
    User.create(
      user_id: "kotaro",
      email: "kotaro@gmail.com",
      password: "iamkotaroyamada"
    )
    user = User.new(
      user_id: "kotaro",
      email: "jiro@gmail.com",
      password: "iamjiroyamada"
    )
    user.valid?
    expect(user.errors[:user_id]).to include("はすでに存在します")
  end
  # 重複したメールなら無効な状態であること
  it "is invalid with a duplicate email" do
    User.create(
      user_id: "kotaro",
      email: "kotaro@gmail.com",
      password: "iamkotaroyamada"
    )
    user = User.new(
      user_id: "jiro",
      email: "kotaro@gmail.com",
      password: "iamjiroyamada"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  # 30文字以上のユーザIDは無効であること
  it "is invalid with user_id with more than 30 characters" do
    user = FactoryBot.build(:user, user_id: "1234567890123456789012345678901")
    user.valid?
    expect(user.errors[:user_id]).to include("は30文字以内で入力してください")
  end
  # 30文字以上のユーザ名は無効であること
  it "is invalid with username with more than 30 characters" do
    user = FactoryBot.build(:user, username: "1234567890123456789012345678901")
    user.valid?
    expect(user.errors[:username]).to include("は30文字以内で入力してください")
  end

  # フォロー・アンフォローを行う
  describe "can follow or unfollow the user" do
    before do
      @user1 = User.create(
        user_id: "kotaro",
        email: "kotaro@gmail.com",
        password: "iamkotaroyamada"        
      )

      @user2 = User.create(
        user_id: "jiro",
        email: "jiro@gmail.com",
        password: "iamjiroyamada"
      )
    end

    # フォローしているとき
    context "when user1 follow user2" do
      before do
        @user1.follow(@user2.id)
      end

      # 既にフォローしているユーザをフォローできない
      it "user1 cannot follow user2" do
        flw = @user1.follow(@user2.id)
        flw.valid?
        expect(flw.errors[:followed_id]).to include("はすでに存在します")
      end
      # アンフォローできる
      it "user1 can unfollow user2" do
        flw = @user1.unfollow(@user2.id)
        expect(flw).to be_valid
      end
      # フォロー確認でtrueとなる
      it "result of following check is true" do
        flw = @user1.following?(@user2)
        expect(flw).to eq true
      end
    end

    # フォローしていないとき
    context "when user1 does not follow user2" do
      # フォローできる
      it "user1 can follow user2" do
        flw = @user1.follow(@user2.id)
        flw.valid?
        expect(flw).to be_valid
      end
      # フォロー確認でfalseとなる
      it "result of following check is false" do
        flw = @user1.following?(@user2)
        expect(flw).to eq false
      end
    end

  end

end
