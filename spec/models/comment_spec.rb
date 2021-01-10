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
  end

  # # 一意性チェック
  # describe "test of uniqueness" do

  # end

  # # 長さの確認
  # describe "test of length" do

  # end

  # # 画像のアップロード
  # describe "check image upload" do

  # end

  # # 削除の依存関係
  # describe "dependent: destoy" do

  # end
end
