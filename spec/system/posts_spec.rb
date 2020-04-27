require 'rails_helper'

describe '投稿管理機能', type: :system do
    describe '一覧表示機能' do
        before do
            user_a = FactoryBot.create(:user, user_id:'mytest1', username:'ユーザーA', email:'a@example.com')
            FactoryBot.create(:post, title: 'テスト投稿1', user: user_a)
        end
        context 'ユーザーAがログインしているとき' do
            before do
                visit new_user_session_path
                fill_in 'ユーザID', with:'mytest1'
                fill_in 'パスワード', with: 'password'
                click_button 'ログイン'
                click_link '投稿一覧'
            end

            it 'ユーザAが作成したタスクが表示される' do
                expect(page).to have_content 'テスト投稿1'
            end
        end
    end
end
