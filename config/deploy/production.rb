server "www.lunchfoo.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/lunchfoo"
set :rails_env, :production