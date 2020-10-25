require 'rails_helper'

RSpec.describe User, type: :model do
  # ユーザID,メール,パスワードがあれば有効な状態であること
  it "is valid with a email and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 存在性チェック
  describe "test of presence" do
    # メールアドレスがなければ無効な状態であること
    it "is invalid without a email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")    
    end

    # パスワードがなければ無効な状態であること
    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")    
    end
  end

  # 一意性チェック
  describe "test of uniqueness" do
    # 重複したメールなら無効な状態であること
    it "is invalid with a duplicate email" do
      User.create(
        email: "kotaro@gmail.com",
        password: "iamkotaroyamada"
      )
      user = User.new(
        email: "kotaro@gmail.com",
        password: "iamjiroyamada"
      )
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end

  # メールアドレスは規定の正規表現に従うこと
  describe "email obeys VALID_EMAIL_REGEX" do
    # ドメインを持たないメールアドレスは無効であること
    it "is invalid with no domain" do
      user = FactoryBot.build(:user, email: "aaa")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
    # ドメインを持つメールアドレスは有効であること
    it "is valid with a domain" do
      user = FactoryBot.build(:user, email: "aaa@ruby.com")
      expect(user).to be_valid
    end
  end

  # 長さの確認
  describe "test of length" do
    # 31文字以上のユーザ名は無効であること
    it "is invalid with username with more than 30 characters" do
      user = FactoryBot.build(:user, username: "あ"*31)
      user.valid?
      expect(user.errors[:username]).to include("は30文字以内で入力してください")
    end
    # 30文字以内のユーザ名は有効であること
    it "is valid with username with 30 characters" do
      user = FactoryBot.build(:user, username: "あ"*30)
      expect(user).to be_valid
    end

    # 5文字のパスワードは無効であること
    it "is invalid with password with 5 characters" do
      user = FactoryBot.build(:user, password: "p"*5)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
    # 129文字のパスワードは無効であること
    it "is invalid with password with 129 characters" do
      user = FactoryBot.build(:user, password: "p"*129)
      user.valid?
      expect(user.errors[:password]).to include("は128文字以内で入力してください")
    end
    # 6文字のパスワードは有効であること
    it "is valid with password with characters betwen 6 and 128" do
      user = FactoryBot.build(:user, password: "p"*6)
      user.valid?
      expect(user).to be_valid
    end
    # 128文字のパスワードは有効であること
    it "is valid with password with characters betwen 6 and 128" do
      user = FactoryBot.build(:user, password: "p"*128)
      user.valid?
      expect(user).to be_valid
    end
  end

  # フォロー・アンフォローを行う
  describe "can follow or unfollow the user" do
    before do
      @user1 = User.create(
        email: "kotaro@gmail.com",
        password: "iamkotaroyamada"        
      )

      @user2 = User.create(
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
      # フォロー確認でtrueとなる
      it "result of following check is true" do
        flw = @user1.following?(@user2)
        expect(flw).to eq true
      end
      # アンフォローできる
      it "user1 can unfollow user2" do
        flw = @user1.unfollow(@user2.id)
        expect(flw).to be_valid
      end
    end

  # 画像のアップロード
  describe "check image upload" do
    # 画像なしでも有効であること
    it "is valid with no image" do
      user = FactoryBot.build(:user, image: nil)
      expect(user).to be_valid
    end

    # 画像なしの場合、デフォルト画像が設定されること
    it "has a default image with no-image" do
      user = FactoryBot.build(:user, image: nil)
      expect(user.image.url).to eq "/assets/no_image.png"
    end

    # デフォルト画像以外の画像を設定できること
    it "can set an image except default image" do
      image_path = Rails.root.join("app/assets/images/homeImg.jpg")
      user = FactoryBot.build(:user, image: File.open(image_path))
      user.save
      expect(user.image.url).to eq "/assets/homeImg.jpg"
    end
  end

    # フォローしていないとき
    context "when user1 does not follow user2" do
      # フォロー確認でfalseとなる
      it "result of following check is false" do
        flw = @user1.following?(@user2)
        expect(flw).to eq false
      end
      # フォローできる
      it "user1 can follow user2" do
        flw = @user1.follow(@user2.id)
        flw.valid?
        expect(flw).to be_valid
      end
    end

  end

end
