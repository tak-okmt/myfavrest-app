require 'rails_helper'

RSpec.describe Post, type: :model do
  # タイトル（店名）がなければ無効な状態であること
  it "is invalid without title" do
    post = FactoryBot.build(:post, title: nil)
    post.valid?
    expect(post.errors[:title]).to include("を入力してください")
  end
  # 30文字以上のタイトル（店名）は無効であること
  it "is invalid with title with more than 30 characters" do
    post = Post.new(
      title: "1234567890123456789012345678901",
    )
    post.valid?
    expect(post.errors[:title]).to include("は30文字以内で入力してください")
  end
  # 店舗説明がなければ無効な状態であること
  it "is invalid without title" do
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("を入力してください")
  end

  # 200文字以上の店舗説明は無効であること

  # 都道府県がなければ無効な状態であること

  # 料理ジャンルがなければ無効な状態であること


end
