# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

# Codeマスタ登録
CSV.foreach('db/seeds/csv/code.csv', headers: false) do |row|
    Code.create!(
        code_id: row[0]
        sub_id: row[1]
        code: row[2]
        name: row[3]
    )
end

# Community登録
CSV.foreach('db/seeds/csv/community.csv', headers: false) do |row|
    Community.create!(
        name: row[0]
        create_user_id: row[1]
        publish_flg: row[2]
        description: row[3]    
    )
end

# Belonging登録
CSV.foreach('db/seeds/csv/belonging.csv', headers: false) do |row|
    Belonging.create!(
        user_id: row[0]
        community_id: row[1]
        admin_flg: row[2]
    )
end

# Userの初期データ
User.create!(
    id: 2,
    email: "test1@example.com",
    password: 'password',
    username: "矢満田太郎",
    birth_ym:   '1997-12-01',
    work_idt:   '1',
    work_ocpn:   '11',
    gender:   '男性'
)

User.create!(
    id: 3,
    email: "test2@example.com",
    password: 'password',
    username: "大江憲三郎",
    birth_ym: '1993-11-01',
    work_idt: '2',
    work_ocpn: '2',
    gender: '男性'
)

User.create!(
    id: 4,
    email: "test3@example.com",
    password: 'password',
    username: "仁志加奈子",
    birth_ym: '1990-02-01',
    work_idt: '3',
    work_ocpn: '14',
    gender:   '女性'
)

User.create!(
    id: 5,
    email: "test4@example.com",
    password: 'password',
    username: "Sari aono",
    birth_ym: '1987-06-01',
    work_idt: '7',
    work_ocpn: '6',
    gender: '女性'
)

User.create!(
    id: 6,
    email: "test5@example.com",
    password: 'password',
    username: "hoshino emiko",
    birth_ym: '1990-11-01',
    work_idt: '5',
    work_ocpn: '9',
    gender: '女性'
)

User.create!(
    id: 7,
    email: "test6@example.com",
    password: 'password',
    username: "大山裕介",
    birth_ym: '1992-08-01',
    work_idt: '3',
    work_ocpn: '15',
    gender: '男性'
)

User.create!(
    id: 8,
    email: "test7@example.com",
    password: 'password',
    username: "畠基博",
    birth_ym: '1977-02-01',
    work_idt: '10',
    work_ocpn: '2',
    gender: '男性'
)

User.create!(
    id: 9,
    email: "test8@example.com",
    password: 'password',
    username: "梅乃柳太郎",
    birth_ym: '1969-01-01',
    work_idt: '3',
    work_ocpn: '1',
    gender: '男性'
)

User.create!(
    id: 10,
    email: "test9@example.com",
    password: 'password',
    username: "仲村英敏",
    birth_ym: '1974-04-01',
    work_idt: '1',
    work_ocpn: '2',
    gender: '男性'
)

User.create!(
    id: 11,
    email: "test10@example.com",
    password: 'password',
    username: "鈴木",
    birth_ym: '1979-09-01',
    work_idt: '9',
    work_ocpn: '2',
    gender: '男性'
)

User.create!(
    id: 12,
    email: "test11@example.com",
    password: 'password',
    username: "小田原幸之助",
    birth_ym: '1989-01-01',
    work_idt: '9',
    work_ocpn: '2',
    gender: '男性'
)

User.create!(
    id: 13,
    email: "test12@example.com",
    password: 'password',
    username: "ai tamura",
    birth_ym: '1986-10-01',
    work_idt: '9',
    work_ocpn: '1',
    gender: '女性'
)

User.create!(
    id: 14,
    email: "test13@example.com",
    password: 'password',
    username: "sumiko etou",
    birth_ym: '1997-08-01',
    work_idt: '7',
    work_ocpn: '6',
    gender: '女性'
)

User.create!(
    id: 15,
    email: "test14@example.com",
    password: 'password',
    username: "田仲日登美",
    birth_ym: '1978-02-01',
    work_idt: '7',
    work_ocpn: '5',
    gender: '女性'
)

User.create!(
    id: 16,
    email: "test15@example.com"
    password: 'password',
    username: "西志村知己",
    birth_ym: '1964-02-01',
    work_idt: '7',
    work_ocpn: '1',
    gender: '女性'
)

User.create!(
    id: 17,
    email: "test16@example.com",
    password: 'password',
    username: "koujoro naitou",
    birth_ym: '1993-04-01',
    work_idt: '11',
    work_ocpn: '3',
    gender: '男性'
)

User.create!(
    id: 18,
    email: "test17@example.com",
    password: 'password',
    username: "katayama sakyou",
    birth_ym: '1994-03-01',
    work_idt: '17',
    work_ocpn: '1',
    gender: '男性'
)

User.create!(
    id: 19,
    email: "test18@example.com",
    password: 'password',
    username: "櫻居日南子",
    birth_ym: '1982-12-01',
    work_idt: '10',
    work_ocpn: '3',
    gender: '女性'
)

User.create!(
    id: 20,
    email: "test19@example.com",
    password: 'password',
    username: "yuusuke",
    birth_ym: '2000-08-01',
    work_idt: '18',
    work_ocpn: '27',
    gender: '男性'
)

User.create!(
    id: 21,
    email: "test20@example.com",
    password: 'password',
    username: "やすゆき",
    birth_ym: '2001-03-01',
    work_idt: '18',
    work_ocpn: '27',
    gender: '男性'
)
