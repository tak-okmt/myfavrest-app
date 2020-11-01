require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:community) { FactoryBot.create(:community) }
  let(:post) { FactoryBot.create(:post) }

  # 存在性チェック
  describe "test of presence" do
    before do
      @valid_post = Post.new(user_id: user.id, community_id: community.id, description: "test", prefecture_code:"1", rest_type:"1")
    end

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
      post.title = "あ"*31
      post.valid?
      expect(post.errors[:title]).to include("は30文字以内で入力してください")
    end
    # 201文字以上の店舗説明は無効であること
    it "is invalid with description with more than 200 characters" do
      post.description = "1"*201
      post.valid?
      expect(post.errors[:description]).to include("は200文字以内で入力してください")
    end
  end

  # 画像のアップロード
  describe "check image upload" do
    # 画像を設定できること
    it "can set an image" do
      image_path = Rails.root.join("app/assets/images/homeImg.jpg")
      post.image.attach(io: File.open(image_path), filename: 'homeImg.jpg', content_type: 'image/jpeg')
      post.save
      expect(post.image).to be_attached
    end
  end

end
