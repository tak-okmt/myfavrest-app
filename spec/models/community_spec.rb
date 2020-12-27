require 'rails_helper'

RSpec.describe Community, type: :model do
  let(:user) { FactoryBot.create(:user) }


# 存在性チェック
  # nameがないものは登録できない
  # １つのユーザは同じ名前のグループを複数登録できない

# 長さの確認
  # name：最大文字数20文字以内
  # description：最大文字数50文字以内

# 画像のアップロード

end
