# マイページ
crumb :mypage do
  link "マイページ", mypage_path
end

# グループ
crumb :community do
  link "グループ一覧", communities_path
end

crumb :community_show do |community|
  link "グループ詳細", community_path(community)
  parent :community
end

crumb :community_edit do |community|
  link "グループ編集", edit_community_path(community)
  parent :community_show, community
end

crumb :community_new do
  link "新規グループ作成", new_community_path
  parent :community
end

# 店舗
crumb :post_show do |community, post|
  link "店舗詳細", community_post_path(community, post)
  parent :community_show, community
end

crumb :post_edit do |community, post|
  link "店舗編集", edit_community_post_path(community, post)
  parent :post_show, community, post
end

crumb :post_new do |community|
  link "新規店舗登録", new_community_post_path(community)
  parent :community_show, community
end

# 口コミ
crumb :comment_show do |community, post, comment|
  link "口コミ詳細", community_post_comment_path(community, post, comment)
  parent :post_show, community, post
end

crumb :comment_edit do |community, post, comment|
  link "口コミ編集", edit_community_post_comment_path(community, post, comment)
  parent :comment_show, community, post, comment
end

crumb :comment_new do |community, post|
  link "口コミ登録", new_community_post_comment_path(community, post)
  parent :post_show, community, post
end

# ユーザ
crumb :user do
  link "ユーザ一覧", users_path
end

crumb :user_show do |user|
  link "ユーザ情報", user_path(user)
  parent :user
end

# フォロー/フォロワー
crumb :follower do |user|
  link "フォロー一覧", follower_user_path(user)
  parent :user_show, user
end

crumb :followed do |user|
  link "フォロワー一覧", followed_user_path(user)
  parent :user_show, user
end

# 申請
crumb :apply do |community|
  link "承認待ちユーザ一覧", community_applies_path(community)
  parent :community_show, community
end

