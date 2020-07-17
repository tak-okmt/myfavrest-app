# config valid only for current version of Capistrano
lock "3.7.0"

# Capistranoのログの表示に利用する
set :application, "myfavrest-app"

# どのリポジトリからアプリをpullするかを指定する
set :repo_url, "git@github.com:gcp632dsh/myfavrest-app.git"

# デプロイ先
set :deploy_to, "/var/www/myapp/myfavrest-app"

# Capistranoがrbenvを認識
set :rbenv_type, :system
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} #{fetch(:rbenv_path)}/bin/rbenv exec"

# アプリケーションで使用するgemはリリース間で共有
# ここに追加したディレクトリは shared ディレクトリ下に配置され、各リリースからはシンボリックリンクで参照される。
append :linked_dirs, '.bundle'

# railsがリリース間で共有するリソースを定義
append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets"
