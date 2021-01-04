require 'rails_helper'

RSpec.describe Community, type: :model do
  let(:user) { FactoryBot.create(:user) }

  before do
    @valid_community = FactoryBot.create(:community, create_user_id: user.id)
  end

  # 存在性チェック
  describe "test of presence" do
    # グループ名、作成ユーザ、公開フラグがあれば有効な状態であること
    it "is valid with name, create_user_id and publish_flg" do
      expect(@valid_community).to be_valid
    end

    # グループ名がなければ無効な状態であること
    it "is invalid without name" do
      @valid_community.name = nil
      @valid_community.valid?
      expect(@valid_community.errors[:name]).to include("を入力してください")
    end

    # 作成者がなければ無効な状態であること
    it "is invalid without create_user_id" do
      @valid_community.create_user_id = nil
      @valid_community.valid?
      expect(@valid_community.errors[:create_user_id]).to include("を入力してください")
    end

    # 公開フラグがなければ無効な状態であること
    it "is invalid without publish_flg" do
      @valid_community.publish_flg = nil
      @valid_community.valid?
      expect(@valid_community.errors[:publish_flg]).to include("を入力してください")
    end
  end

  # 一意性チェック
  describe "test of uniqueness" do
    # １つのユーザは同じ名前のグループを複数登録できない
    it "is invalid with duplicate name for one user" do
      @valid_community2 = FactoryBot.build(:community, create_user_id: user.id)
      @valid_community2.valid?
      expect(@valid_community2.errors[:name]).to include("はすでに存在します")
    end
  end

  # 長さの確認
  describe "test of length" do
    # 20文字以内の名前は有効であること
    it "is valid with name with less than 20 characters" do
      @valid_community.name = "あ" * 20
      @valid_community.valid?
      expect(@valid_community).to be_valid
    end

    # 21文字以上の名前は無効であること
    it "is invalid with name with more than 21 characters" do
      @valid_community.name = "あ" * 21
      @valid_community.valid?
      expect(@valid_community.errors[:name]).to include("は20文字以内で入力してください")
    end

    # 50文字以内の説明は有効であること
    it "is valid with description with less than 50 characters" do
      @valid_community.description = "あ" * 50
      @valid_community.valid?
      expect(@valid_community).to be_valid
    end

    # 51文字以上の説明は無効であること
    it "is invalid with description with more than 51 characters" do
      @valid_community.description = "あ" * 51
      @valid_community.valid?
      expect(@valid_community.errors[:description]).to include("は50文字以内で入力してください")
    end
  end

  # 画像のアップロード
  describe "check image upload" do
    # 画像を設定できること（jpg）
    it "can set an image of jpg" do
      image_path = Rails.root.join("app/assets/images/homeImg.jpg")
      @valid_community.image.attach(io: File.open(image_path), filename: 'homeImg.jpg', content_type: 'image/jpeg')
      @valid_community.save
      expect(@valid_community.image).to be_attached
    end

    # 画像を設定できること（jpeg）
    it "can set an image of jpeg" do
      image_path = Rails.root.join("app/assets/images/test_img.jpeg")
      @valid_community.image.attach(io: File.open(image_path), filename: 'test_img.jpeg', content_type: 'image/jpeg')
      @valid_community.save
      expect(@valid_community.image).to be_attached
    end

    # 画像を設定できること（gif）
    it "can set an image of gif" do
      image_path = Rails.root.join("app/assets/images/test_img.gif")
      @valid_community.image.attach(io: File.open(image_path), filename: 'test_img.gif', content_type: 'image/gif')
      @valid_community.save
      expect(@valid_community.image).to be_attached
    end

    # 画像を設定できること（png）
    it "can set an image of png" do
      image_path = Rails.root.join("app/assets/images/test_img.png")
      @valid_community.image.attach(io: File.open(image_path), filename: 'test_img.png', content_type: 'image/png')
      @valid_community.save
      expect(@valid_community.image).to be_attached
    end

    # 1MBを超える画像はアップロードできないこと
    it "can not upload an image over 1MB" do
      image_path = Rails.root.join("app/assets/images/over_1MB.jpg")
      @valid_community.image.attach(io: File.open(image_path), filename: 'over_1MB.jpg', content_type: 'image/jpeg')
      @valid_community.valid?
      expect(@valid_community.errors[:image]).to include "は1MB以下にする必要があります"
    end

    # ファイル拡張子が不適切な場合はアップロードできないこと
    it "can not upload an inappropriate file extension" do
      image_path = Rails.root.join("app/assets/images/inappropriate_image.csv")
      @valid_community.image.attach(io: File.open(image_path), filename: 'inappropriate_image.csv', content_type: 'text/csv')
      @valid_community.valid?
      expect(@valid_community.errors[:image]).to include "ファイル拡張子が適切ではありません"
    end
  end

  # 削除の依存関係
  describe "dependent: destoy" do
    # 削除すると、紐づく店舗も全て削除されること
    it "destroys all posts when deleted" do
      2.times { FactoryBot.create(:post, user: user, community: @valid_community) }
      expect { @valid_community.destroy }.to change(@valid_community.posts, :count).by(-2)
    end

    # 削除すると、紐づく所属情報も全て削除されること
    it "destroys all belongings when deleted" do
      Belonging.create(user_id: user.id, community_id: @valid_community.id)
      expect { @valid_community.destroy }.to change(@valid_community.belongings, :count).by(-1)
    end

    # 削除すると、紐づく加入申請情報も全て削除されること
    it "destroys all applies when deleted" do
      Apply.create(user_id: user.id, community_id: @valid_community.id)
      expect { @valid_community.destroy }.to change(@valid_community.applies, :count).by(-1)
    end
  end
end
