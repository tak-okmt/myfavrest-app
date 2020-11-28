# config valid only for current version of Capistrano
lock "3.7.0"

# Capistranoのログの表示に利用する
set :application, "myfavrest-app"

# SSH接続ユーザ
set :user, "ec2-user"

# どのリポジトリからアプリをpullするかを指定する
set :repo_url, "git@github.com:gcp632dsh/myfavrest-app.git"

# デバッグ用に詳細ログを出力
set :log_level, :debug

# サーバ上でのソースの配置先
set :deploy_to, "/home/#{fetch(:user)}/var/www/#{fetch(:application)}"

# リソース間での共有リソースを定義
set :linked_files, fetch(:linked_files, []).push("config/master.key")
append :linked_files, "config/database.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets"

# 何世代前までリリースを残しておくか
set :keep_releases, 3

# ----------カスタマイズしたタスク------------
namespace :deploy do
    # linked_filesで使用するファイルをアップロードするタスク。deploy前に実行する。
    desc 'upload linked_files'
    task :upload do
        on roles(:app) do |_host|
            execute :mkdir, '-p', "#{shared_path}/config"
            upload!('config/database.yml', "#{shared_path}/config/database.yml")
            upload!('config/master.key', "#{shared_path}/config/master.key")

            # puma.rbをデプロイ時に毎回作成する
            invoke 'puma:config'
        end
    end
end

# nginxの起動・停止・再起動
namespace :nginx do
    %w[start stop restart].each do |command|
        desc "#{command} nginx"
        task command.to_s do
            on roles(:web) do
                sudo "service nginx #{command}"
            end
        end
    end
end

# capistrano内の変数一覧表示
namespace :config do
    desc 'show variables'
    task :display do
        Capistrano::Configuration.env.keys.each do |key|
        puts "#{key} => #{fetch(key)}"
        end
    end
end

# デプロイ開始前のサーバ停止タスク(nginx => puma)
# before 'deploy:starting', 'nginx:stop'
# after 'nginx:stop', 'puma:stop'
# after 'puma:stop', 'deploy:upload'

# デプロイ完了後のサーバ起動タスク(puma => nginx)。pumaの起動タイミングはデプロイ直後で、gemで挿入済みのため記述しない
after 'puma:start', 'nginx:start'
