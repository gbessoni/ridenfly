server '157.245.138.138', user: 'deployer', roles: %w{web app db}

set :rails_env, 'production'
set :unicorn_env, 'production'
set :unicorn_rack_env, 'production'
set :branch, 'master'
