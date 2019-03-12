server '136.243.44.155', user: 'deployer', roles: %w{web app db}

set :rails_env, "production"
set :branch, "master"
