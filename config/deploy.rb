require "bundler/capistrano"

set :rvm_ruby_string, 'ruby-1.9.3-p362@global'
set :rvm_type, :system

require "rvm/capistrano"


ssh_options[:forward_agent] = true

set :application, "lunchfoo"

#set :rvm_ruby_string, "1.9.3-p362"


set :scm, :git
set :repository, "git@github.com:bassgs3000/lunch.git"
set :branch, "deploy"
set :scm_passphrase, ""
set :deploy_via, :remote_cache
set :keep_releases, 10

set :rvm_path, "/usr/local/rvm"
set :user, "root"
set :normalize_asset_timestamps, false
set :rake, "/usr/local/rvm/gems/ruby-1.9.3-p374@global/bin/rake"



server "www.lunchfoo.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/lunchfoo"
set :rails_env, :production