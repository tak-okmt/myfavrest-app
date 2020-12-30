require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:community) { FactoryBot.create(:community) }

  before do
    @com = Community.create(name: "1" * 8, create_user_id: user.id, publish_flg: 1)
    @valid_post = FactoryBot.create(:post, user: user, community: @com)
  end

  # 存在性チェック
  describe "test of presence" do
    # タイトル（店名）、店舗説明、都道府県、料理ジャンルがあれば有効な状態であること
    it "is valid with title,description,prefecture_code and rest_type" do
      expect(@valid_post).to be_valid
    end

    # タイトル（店名）がなければ無効な状態であること
    it "is invalid without title" do
      @valid_post.title = nil
      @valid_post.valid?
      expect(@valid_post.errors[:title]).to include("を入力してください")
    end
    # 店舗説明がなければ無効な状態であること
    it "is invalid without description" do
      @valid_post.description = nil
      @valid_post.valid?
      expect(@valid_post.errors[:description]).to include("を入力してください")
    end
    # 都道府県がなければ無効な状態であること
    it "is invalid without prefecture_code" do
      @valid_post.prefecture_code = nil
      @valid_post.valid?
      expect(@valid_post.errors[:prefecture_code]).to include("を入力してください")
    end
    # 料理ジャンルがなければ無効な状態であること
    it "is invalid without rest_type" do
      @valid_post.rest_type = nil
      @valid_post.valid?
      expect(@valid_post.errors[:rest_type]).to include("を入力してください")
    end
  end

  # 長さの確認
  describe "test of length" do
    # 31文字以上のタイトル（店名）は無効であること
    it "is invalid with title with more than 30 characters" do
      @valid_post.title = "あ" * 31
      @valid_post.valid?
      expect(@valid_post.errors[:title]).to include("は30文字以内で入力してください")
    end
    # 201文字以上の店舗説明は無効であること
    it "is invalid with description with more than 200 characters" do
      @valid_post.description = "1" * 201
      @valid_post.valid?
      expect(@valid_post.errors[:description]).to include("は200文字以内で入力してください")
    end
  end

  # 画像のアップロード
  describe "check image upload" do
    # 画像を設定できること（jpg）
    it "can set an image of jpg" do
      image_path = Rails.root.join("app/assets/images/homeImg.jpg")
      @valid_post.image.attach(io: File.open(image_path), filename: 'homeImg.jpg', content_type: 'image/jpeg')
      @valid_post.save
      expect(@valid_post.image).to be_attached
    end

    # 画像を設定できること（jpeg）
    it "can set an image of jpeg" do
      image_path = Rails.root.join("app/assets/images/test_img.jpeg")
      @valid_post.image.attach(io: File.open(image_path), filename: 'test_img.jpeg', content_type: 'image/jpeg')
      @valid_post.save
      expect(@valid_post.image).to be_attached
    end

    # 画像を設定できること（gif）
    it "can set an image of gif" do
      image_path = Rails.root.join("app/assets/images/test_img.gif")
      @valid_post.image.attach(io: File.open(image_path), filename: 'test_img.gif', content_type: 'image/gif')
      @valid_post.save
      expect(@valid_post.image).to be_attached
    end

    # 画像を設定できること（png）
    it "can set an image of png" do
      image_path = Rails.root.join("app/assets/images/test_img.png")
      @valid_post.image.attach(io: File.open(image_path), filename: 'test_img.png', content_type: 'image/png')
      @valid_post.save
      expect(@valid_post.image).to be_attached
    end

    # 5MBを超える画像はアップロードできないこと
    it "can not upload an image over 5MB" do
      image_path = Rails.root.join("app/assets/images/over_5MB.jpg")
      @valid_post.image.attach(io: File.open(image_path), filename: 'over_5MB.jpg', content_type: 'image/jpeg')
      @valid_post.valid?
      expect(@valid_post.errors[:image]).to include "は5MB以下にする必要があります"
    end

    # ファイル拡張子が不適切な場合はアップロードできないこと
    it "can not upload an inappropriate file extension" do
      image_path = Rails.root.join("app/assets/images/inappropriate_image.csv")
      @valid_post.image.attach(io: File.open(image_path), filename: 'inappropriate_image.csv', content_type: 'text/csv')
      @valid_post.valid?
      expect(@valid_post.errors[:image]).to include "ファイル拡張子が適切ではありません"
    end
  end

  # 削除の依存関係
  describe "dependent: destoy" do
    # 削除すると、紐づくいいねも全て削除されること
    it "destroys all likes when deleted" do
      Like.create(user_id:user.id ,post_id: @valid_post.id)
      expect { @valid_post.destroy }.to change(user.likes, :count).by(-1)
    end

    # 削除すると、紐づくコメントも全て削除されること
    it "destroys all comments when deleted" do
      Comment.create(content:"test", user_id:user.id, post_id:@valid_post.id, score:5, visitday: "2020/09/08")
      expect { @valid_post.destroy }.to change(@valid_post.comments, :count).by(-1)
    end
  end

end
