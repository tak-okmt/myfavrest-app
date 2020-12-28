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
    
    # １つのユーザは同じ名前のグループを複数登録できない


  end


# 長さの確認
  # name：最大文字数20文字以内
  # description：最大文字数50文字以内

# 画像のアップロード

end
