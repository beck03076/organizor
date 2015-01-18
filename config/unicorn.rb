app_path = "/home/deployer/apps/organizor/current"
shared_path = "/home/deployer/apps/organizor/shared"

worker_processes   2
preload_app        true
timeout            30
listen             "/tmp/unicorn.organizor.sock"
listen             8080, :tcp_nopush => true
working_directory  app_path

pid                "#{shared_path}/tmp/pids/unicorn.pid"
stderr_path        "#{shared_path}/log/unicorn.log"
stdout_path        "#{shared_path}/log/unicorn.log"

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

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
  ActiveRecord::Base.establish_connection
end
