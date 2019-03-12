server '136.243.88.42', user: 'deployer', roles: %w{web app db}

set :rails_env, "staging"
set :branch, "develop"
