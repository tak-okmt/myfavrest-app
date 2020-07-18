require "capistrano/setup"
require "capistrano/deploy"

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

# add requires
require 'capistrano/bundler'
require 'capistrano/rbenv'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }