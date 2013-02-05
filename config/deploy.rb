require "bundler/capistrano"

set :rvm_ruby_string, 'ruby-1.9.3-p362'
set :rvm_type, :system
set :rvm_install_pkgs, %w[libyaml openssl]
set :rvm_install_ruby_params, '--with-opt-dir=/usr/local/rvm/usr'

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'
before 'deploy:setup', 'rvm:install_pkgs'

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

after "deploy", "rvm:trust_rvmrc"


require "rvm/capistrano"


ssh_options[:forward_agent] = true

set :application, "lunchfoo"

# set :rvm_ruby_string, "1.9.3-p362"

set :scm, :git
set :repository, "git@github.com:bassgs3000/lunch.git"
set :branch, "deploy"
set :scm_passphrase, ""
set :deploy_via, :remote_cache
set :keep_releases, 10
set :user, "root"
set :normalize_asset_timestamps, false
# set :rake, "/usr/local/rvm/gems/ruby-1.9.3-p374@global/bin/rake"



server "www.lunchfoo.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/lunchfoo"
set :rails_env, :production

namespace :db do
  task :db_config, :except => { :no_release => true }, :role => :app do
    run "cp -f ~/database.yml #{release_path}/config/database.yml"
  end
end

before "deploy:migrate", "db:db_config"

namespace :deploy do
  task :precompile, :role => :app do
    run "cd #{release_path}/ && rake assets:precompile"
  end
end

after "deploy", "deploy:precompile"
