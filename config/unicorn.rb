  app_path = "/home/deployer/ridenfly.com/current"
  working_directory app_path

  pid "#{app_path}/tmp/pids/unicorn.pid"

  stderr_path "#{app_path}/log/unicorn_error.log"
  stdout_path "#{app_path}/log/unicorn_output.log"

  # worker_processes Integer(ENV['WEB_CONCURRENCY'])

  worker_processes 2
  timeout 10
  preload_app true

  listen "#{app_path}/tmp/sockets/unicorn.sock", backlog: 64

  before_fork do |server, worker|
    # the following is highly recomended for Rails + "preload_app true"
    # as there's no need for the master process to hold a connection
    if defined?(ActiveRecord::Base)
      ActiveRecord::Base.connection.disconnect!
    end

    # Before forking, kill the master process that belongs to the .oldbin PID.
    # This enables 0 downtime deploys.
    old_pid = "#{server.config[:pid]}.oldbin"
    if File.exists?(old_pid) && server.pid != old_pid
      begin
        Process.kill("QUIT", File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
        # someone else did our job for us
      end
    end
  end

  after_fork do |server, worker|
    if defined?(ActiveRecord::Base)
      ActiveRecord::Base.establish_connection
    end
  end

  # Force the bundler gemfile environment variable to
  # reference the capistrano "current" symlink
  before_exec do |_|
    ENV['BUNDLE_GEMFILE'] = File.join(app_path, 'Gemfile')
  end