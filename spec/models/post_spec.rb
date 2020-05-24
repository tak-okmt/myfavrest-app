require 'rails_helper'

RSpec.describe Post, type: :model do
  # タイトルがなければ無効な状態であること
  it "is invalid without title" do
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("を入力してください")
  end
  # 30文字以上の店名は無効であること
  it "is invalid with title with more than 30 characters" do
    post = Post.new(
      title: "1234567890123456789012345678901",
    )
    post.valid?
    expect(post.errors[:title]).to include("は30文字以内で入力してください")
  end
  # ユーザ単位では、重複した店名を許可しないこと
  it "does not allow duplicate post titles per user" do
    user = FactoryBot.create(:user)
    user.posts.create(
      title: "テスト店舗"
    )

    new_post = user.posts.build(
      title: "テスト店舗"
    )

    new_post.valid?
    expect(new_post.errors[:title]).to include("はすでに存在します")
  end
  # ユーザが異なる場合、重複した店名を許可すること
  it "allow two users to share a post title" do
    user = FactoryBot.create(:user)
    user.posts.create(
      title: "テスト店舗"
    )

    other_user = User.create(
      user_id: "jiro",
      email: "jiro@gmail.com",
      password: "iamkotaroyamada"
    )
    other_post = other_user.posts.create(
      title: "テスト店舗"
    )

    expect(other_post).to be_valid
  end
  # コンマが含まれる店名は無効な状態であること
  it "is invalid with title including comma" do
    post = Post.new(title: "テスト,店舗")
    post.valid?
    expect(post.errors[:title]).to include("にカンマを含めることはできません")
  end

end
