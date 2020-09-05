# トランザクション系の初期データ
User.seed do |s|
    s.id = 2
    s.email = "test1@example.com"
    s.password  = 'password'
    s.username  = "テスト1"
    s.birth_ym  = '1995-01-01'
    s.work_idt  = '1'
    s.work_comp = 'テスト株式会社'
    s.work_ocpn = '1'
end

Community.seed do |s|
    s.id = 1
    s.name = '公開誰でもコミュニティ'
    s.create_user_id = '2'
    s.publish_flg = '0'
    s.description = 'デフォルトで全ユーザー参加している、皆様のためのコミュニティです。'
end

Post.seed do |s|
    s.title = 'テスト店舗'
    s.description = 'テスト用の店舗です。'
    s.user_id = '1'
    s.prefecture_code = '13'
    s.community_id = '1'
end

Belonging.seed do |s|
    s.id = 1
    s.user_id = '1'
    s.community_id = '1'
    s.admin_flg = '1'
end

Belonging.seed do |s|
    s.id = 2
    s.user_id = '2'
    s.community_id = '1'
    s.admin_flg = '0'
end
