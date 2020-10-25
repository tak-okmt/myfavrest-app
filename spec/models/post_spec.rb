require 'rails_helper'

RSpec.describe Post, type: :model do
  # タイトル（店名）、店舗説明、都道府県、料理ジャンルがあれば有効な状態であること
  it "is valid with title,description,prefecture_code and rest_type" do
    post = FactoryBot.build(:post)
    post.valid?
    expect(post).to be_valid
  end

  # タイトル（店名）がなければ無効な状態であること
  it "is invalid without title" do
    post = FactoryBot.build(:post, title: nil)
    post.valid?
    expect(post.errors[:title]).to include("を入力してください")
  end
  # 31文字以上のタイトル（店名）は無効であること
  it "is invalid with title with more than 30 characters" do
    post = FactoryBot.build(:post,
      title: "1234567890123456789012345678901"
    )
    post.valid?
    expect(post.errors[:title]).to include("は30文字以内で入力してください")
  end
  # 店舗説明がなければ無効な状態であること
  it "is invalid without description" do
    post = FactoryBot.build(:post, description: nil)
    post.valid?
    expect(post.errors[:description]).to include("を入力してください")
  end
  # 201文字以上の店舗説明は無効であること
  it "is invalid with description with more than 200 characters" do
    post = FactoryBot.build(:post, 
      description: "1"*201)
    post.valid?
    expect(post.errors[:description]).to include("は200文字以内で入力してください")
  end
  # 都道府県がなければ無効な状態であること
  it "is invalid without prefecture_code" do
    post = FactoryBot.build(:post, prefecture_code: nil)
    post.valid?
    expect(post.errors[:prefecture_code]).to include("を入力してください")
  end
  # 料理ジャンルがなければ無効な状態であること
  it "is invalid without rest_type" do
    post = FactoryBot.build(:post, rest_type: nil)
    post.valid?
    expect(post.errors[:rest_type]).to include("を入力してください")
  end

end
