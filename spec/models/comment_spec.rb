require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:community) { FactoryBot.create(:community) }
  let(:post) { FactoryBot.create(:post, user: user, community: community) }

  before do
    @valid_comment = FactoryBot.create(:comment, user_id: user.id, post_id: post.id)
  end

  # 存在性チェック
  describe "test of presence" do
    # 内容、評価、訪問日があれば有効な状態であること
    it "is valid with content, score and visitday" do
      expect(@valid_comment).to be_valid
    end

    # 内容がなければ無効な状態であること
    it "is invalid without content" do
      @valid_comment.content = nil
      @valid_comment.valid?
      expect(@valid_comment.errors[:content]).to include("を入力してください")
    end

    # 評価がなければ無効な状態であること
    it "is invalid without score" do
      @valid_comment.score = nil
      @valid_comment.valid?
      expect(@valid_comment.errors[:score]).to include("を入力してください")
    end

    # 訪問日がなければ無効な状態であること
    it "is invalid without visitday" do
      @valid_comment.visitday = nil
      @valid_comment.valid?
      expect(@valid_comment.errors[:visitday]).to include("を入力してください")
    end
  end

  # 長さの確認
  describe "test of length" do
    # 300文字以内の内容は有効であること
    it "is invalid with content with 300 characters" do
      @valid_comment.content = "あ" * 300
      @valid_comment.valid?
      expect(@valid_comment).to be_valid
    end

    # 301文字以上の内容は無効であること
    it "is invalid with content with more than 300 characters" do
      @valid_comment.content = "あ" * 301
      @valid_comment.valid?
      expect(@valid_comment.errors[:content]).to include("は300文字以内で入力してください")
    end
  end

  # 画像のアップロード
  describe "check image upload" do
    # 画像を設定できること（jpg）
    it "can set an image of jpg" do
      image_path = Rails.root.join("app/assets/images/homeImg.jpg")
      @valid_comment.image.attach(io: File.open(image_path), filename: 'homeImg.jpg', content_type: 'image/jpeg')
      @valid_comment.save
      expect(@valid_comment.image).to be_attached
    end

    # 画像を設定できること（jpeg）
    it "can set an image of jpeg" do
      image_path = Rails.root.join("app/assets/images/test_img.jpeg")
      @valid_comment.image.attach(io: File.open(image_path), filename: 'test_img.jpeg', content_type: 'image/jpeg')
      @valid_comment.save
      expect(@valid_comment.image).to be_attached
    end

    # 画像を設定できること（gif）
    it "can set an image of gif" do
      image_path = Rails.root.join("app/assets/images/test_img.gif")
      @valid_comment.image.attach(io: File.open(image_path), filename: 'test_img.gif', content_type: 'image/gif')
      @valid_comment.save
      expect(@valid_comment.image).to be_attached
    end

    # 画像を設定できること（png）
    it "can set an image of png" do
      image_path = Rails.root.join("app/assets/images/test_img.png")
      @valid_comment.image.attach(io: File.open(image_path), filename: 'test_img.png', content_type: 'image/png')
      @valid_comment.save
      expect(@valid_comment.image).to be_attached
    end

    # 1MBを超える画像はアップロードできないこと
    it "can not upload an image over 1MB" do
      image_path = Rails.root.join("app/assets/images/over_1MB.jpg")
      @valid_comment.image.attach(io: File.open(image_path), filename: 'over_1MB.jpg', content_type: 'image/jpeg')
      @valid_comment.valid?
      expect(@valid_comment.errors[:image]).to include "は1MB以下にする必要があります"
    end

    # ファイル拡張子が不適切な場合はアップロードできないこと
    it "can not upload an inappropriate file extension" do
      image_path = Rails.root.join("app/assets/images/inappropriate_image.csv")
      @valid_comment.image.attach(io: File.open(image_path), filename: 'inappropriate_image.csv', content_type: 'text/csv')
      @valid_comment.valid?
      expect(@valid_comment.errors[:image]).to include "ファイル拡張子が適切ではありません"
    end
  end
end
