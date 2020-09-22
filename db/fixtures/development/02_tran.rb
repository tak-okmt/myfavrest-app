# トランザクション系の初期データ
User.seed do |s|
    s.id = 1
    s.email = "test1@example.com"
    s.password  = 'password'
    s.username  = "テスト1"
    s.birth_ym  = '1995-01-01'
    s.work_idt  = '1'
    s.work_comp = 'テスト株式会社'
    s.work_ocpn = '1'
end

20.times {
    User.seed do |s|
        s.email = Faker::Internet.email
        s.password  = 'password'
        s.username  = Faker::Internet.user_name
        s.birth_ym  = '1995-01-01'
        s.work_idt  = SecureRandom.random_number(1..4)
        s.work_comp = Faker::Company.name
        s.work_ocpn = SecureRandom.random_number(1..4)
    end
}

Community.seed do |s|
    s.id = 1
    s.name = '公開誰でもグループ'
    s.create_user_id = '2'
    s.publish_flg = '0'
    s.description = 'デフォルトで全ユーザーが参加している、皆様のためのグループです。'
end

20.times {
    Community.seed do |s|
        s.name = Faker::Company.name
        s.create_user_id = '1'
        s.publish_flg = '0'
        s.description = 'テスト登録用グループです。'
    end
}

20.times {
    Post.seed do |s|
        s.title = Faker::Restaurant.name
        s.description = Faker::Restaurant.description
        s.user_id = '1'
        s.prefecture_code = '13'
        s.community_id = '1'
    end
}

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
