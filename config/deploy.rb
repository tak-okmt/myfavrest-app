# config valid only for current version of Capistrano
lock "3.7.0"

# Capistranoのログの表示に利用する
set :application, "myfavrest-app"

# どのリポジトリからアプリをpullするかを指定する
set :repo_url, "git@github.com:gcp632dsh/myfavrest-app.git"

# サーバ上でのソースの配置先
set :deploy_to, "/var/www/apps/myapp"

# Rubyをrbenv経由で使う
set :rbenv_type, :system
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} #{fetch(:rbenv_path)}/bin/rbenv exec"

# アプリケーションで使用するgemをリリース間で共有
append :linked_dirs, '.bundle'

# サーバの並列数
set :bundle_jobs, 2

# リリース間での共有リソース定義
append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets"


