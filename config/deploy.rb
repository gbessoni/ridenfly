# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'ridenfly'
set :repo_url, 'git@bitbucket.org:railss/ridenfly.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/deployer/ridenfly.com"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :whenever_roles, :app
set :whenever_environment, ->{ fetch(:rails_env) }
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:rails_env)}" }

set :rvm_type, :user
set :rvm_ruby_version, '2.3.1'

set :rollbar_token, '54973eddc73a4ded88f772fd62e9c4cf'
set :rollbar_env, proc { fetch :stage }
set :rollbar_role, proc { :app }

set :unicorn_config_path,-> { "#{current_path}/config/unicorn.rb" }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
  end
end
