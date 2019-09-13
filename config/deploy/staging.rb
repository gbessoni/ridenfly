server '134.209.220.200', user: 'deployer', roles: %w{web app db}

set :rails_env, 'staging'
set :unicorn_env, 'staging'
set :unicorn_rack_env, 'staging'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
