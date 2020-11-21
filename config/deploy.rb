# config valid only for current version of Capistrano
lock "3.7.0"

# Capistranoのログの表示に利用する
set :application, "myfavrest-app"

# SSH接続ユーザ
set :user, "ec2-user"

# どのリポジトリからアプリをpullするかを指定する
set :repo_url, "git@github.com:gcp632dsh/myfavrest-app.git"

# サーバ上でのソースの配置先
set :deploy_to, "/home/#{fetch(:user)}/var/www/#{fetch(:application)}"

# Rubyをrbenv経由で使う
# rbenv のインストール先はデプロイ先ユーザーのホームディレクトリ
set :rbenv_type, :user
# .ruby_version を使用して rbenv のバージョンを指定している
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} #{fetch(:rbenv_path)}/bin/rbenv exec"

# アプリケーションで使用するgemをリリース間で共有
append :linked_dirs, '.bundle'

# サーバの並列数
set :bundle_jobs, 2

set :keep_releases, 5

set :log_level, :debug

# 自動生成されるpuma.rbのソケット通信パスを以下に変更
set :puma_bind, %w[unix:///tmp/sockets/puma.sock]

# git cloneブランチの指定
# カレントブランチを標準出力から取得し、chompで末尾の改行コードを削除する
current_branch = `git symbolic-ref --short HEAD`.chomp
set :branch, ENV['BRANCH'] || current_branch

# 以下ファイルはそのままでは読み込まれず、shared配下に置く必要があるため、リンク対象としてシンボリックリンクを作成する
set :linked_files, fetch(:linked_files, []).push("config/master.key")
append :linked_files, "config/database.yml"

# タスク内でsudoする場合、trueにする
set :pty, true

# git管理対象外のディレクトリはシンボリックリンク化する
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

# assetsディレクトリの削除
namespace :assets do
    desc 'remove assets directory'
    task :rm do
        on roles(:web) do
            sudo "rm -rf /home/ec2-user/environment/chilled/shared/public/assets"
        end
    end
end

# デバッグ用
# before '任意のタスク', 'console'

# デプロイ開始前のサーバ停止タスク(nginx => puma)
before 'deploy:starting', 'nginx:stop'
after 'nginx:stop', 'puma:stop'
after 'puma:stop', 'redis:stop'
after 'deploy:upload', 'assets:rm'

# デプロイ完了後のサーバ起動タスク(puma => nginx)。pumaの起動タイミングはデプロイ直後で、gemで挿入済みのため記述しない
before 'puma:start', 'redis:start'
after 'puma:start', 'nginx:start'
