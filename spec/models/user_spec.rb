require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:community) { FactoryBot.create(:community) }

  # ユーザID,メール,パスワードがあれば有効な状態であること
  it "is valid with a email and password" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 存在性チェック
  describe "test of presence" do
    # メールアドレスがなければ無効な状態であること
    it "is invalid without a email" do
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    # パスワードがなければ無効な状態であること
    it "is invalid without a password" do
      user.password = ""
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
  end

  # 一意性チェック
  describe "test of uniqueness" do
    # 重複したメールなら無効な状態であること
    it "is invalid with a duplicate email" do
      user.save
      dupulicate_user = FactoryBot.build(:user, email: user.email)
      dupulicate_user.valid?
      expect(dupulicate_user.errors[:email]).to include("はすでに存在します")
    end
  end

  # メールアドレスは規定の正規表現に従うこと
  describe "email obeys VALID_EMAIL_REGEX" do
    # ドメインを持たないメールアドレスは無効であること
    it "is invalid with no domain" do
      user.email = "aaa"
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
    # ドメインを持つメールアドレスは有効であること
    it "is valid with a domain" do
      user.email = "aaa@ruby.com"
      expect(user).to be_valid
    end
  end

  # 長さの確認
  describe "test of length" do
    # 31文字以上のユーザ名は無効であること
    it "is invalid with username with more than 30 characters" do
      user.username = "あ" * 31
      user.valid?
      expect(user.errors[:username]).to include("は30文字以内で入力してください")
    end
    # 30文字以内のユーザ名は有効であること
    it "is valid with username with 30 characters" do
      user.username = "あ" * 30
      expect(user).to be_valid
    end

    # 5文字のパスワードは無効であること
    it "is invalid with password with 5 characters" do
      user.password = "p" * 5
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
    # 129文字のパスワードは無効であること
    it "is invalid with password with 129 characters" do
      user.password = "p" * 129
      user.valid?
      expect(user.errors[:password]).to include("は128文字以内で入力してください")
    end
    # 6文字のパスワードは有効であること
    it "is valid with password with characters betwen 6 and 128" do
      user.password = "p" * 6
      user.valid?
      expect(user).to be_valid
    end
    # 128文字のパスワードは有効であること
    it "is valid with password with characters betwen 6 and 128" do
      user.password = "p" * 128
      user.valid?
      expect(user).to be_valid
    end
  end

  # 画像のアップロード
  describe "check image upload" do
    # 画像を設定できること
    it "can set an image" do
      image_path = Rails.root.join("app/assets/images/homeImg.jpg")
      user.image.attach(io: File.open(image_path), filename: 'homeImg.jpg', content_type: 'image/jpeg')
      user.save
      expect(user.image).to be_attached
    end
  end

  # フォロー・アンフォローを行う
  describe "can follow or unfollow the user" do
    # フォローしているとき
    context "when user1 follow user2" do
      before do
        user1.follow(user2.id)
      end

      # 既にフォローしているユーザをフォローできない
      it "user1 cannot follow user2" do
        flw = user1.follow(user2.id)
        flw.valid?
        expect(flw.errors[:followed_id]).to include("はすでに存在します")
      end
      # フォロー確認でtrueとなる
      it "result of following check is true" do
        flw = user1.following?(user2)
        expect(flw).to eq true
      end
      # アンフォローできる
      it "user1 can unfollow user2" do
        flw = user1.unfollow(user2.id)
        expect(flw).to be_valid
      end
    end

    # フォローしていないとき
    context "when user1 does not follow user2" do
      # フォロー確認でfalseとなる
      it "result of following check is false" do
        flw = user1.following?(user2)
        expect(flw).to eq false
      end
      # フォローできる
      it "user1 can follow user2" do
        flw = user1.follow(user2.id)
        flw.valid?
        expect(flw).to be_valid
      end
    end
  end

  # 削除の依存関係
  describe "dependent: destoy" do
    before do
      @com = Community.create(name: "1" * 8, create_user_id: user.id, publish_flg: 1)
    end

    # 削除すると、紐づく店舗も全て削除されること
    it "destroys all posts when deleted" do
      2.times { FactoryBot.create(:post, user: user, community: @com) }
      expect { user.destroy }.to change(user.posts, :count).by(-2)
    end
  end

  # # 削除すると、紐づくいいねも全て削除されること
  # it "destroys all followers when deleted" do

  # end

  # # 削除すると、紐づく口コミも全て削除されること
  # it "destroys all followers when deleted" do

  # end

  # # 削除すると、紐づく所属情報も全て削除されること
  # it "destroys all followers when deleted" do

  # end

  # # 削除すると、紐づく加入申請も全て削除されること
  # it "destroys all followers when deleted" do

  # end

  # # 削除すると、紐づくフォローも全て削除されること
  # it "destroys all follows when deleted" do

  # end

  # # 削除すると、紐づくフォロワーも全て削除されること
  # it "destroys all followers when deleted" do

  # end
end
