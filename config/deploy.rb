require 'capistrano/ext/multistage'

set :application, "lunchfoo"
set :scm, :git
set :repository, "git@github.com:bassgs3000/lunch.git"
set :branch, "deploy"
set :scm_passphrase, ""
set :user, "root"
set :stages, "production"
set :default_stage, "production"
