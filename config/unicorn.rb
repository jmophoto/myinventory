root = "/home/inspeckd/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.inspeckd.sock"
worker_processes 2
timeout 30

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end



# # ------------------------------------------------------------------------------
# # Sample rails 3 config
# # ------------------------------------------------------------------------------
# 
# # Set your full path to application.
# app_path = "/home/inspeckd/current"
# 
# # Set unicorn options
# worker_processes 1
# preload_app true
# timeout 180
# listen "127.0.0.1:8080"
# 
# # Spawn unicorn master worker for user apps (group: apps)
# user 'apps', 'apps' 
# 
# # Fill path to your app
# working_directory app_path
# 
# # Should be 'production' by default, otherwise use other env 
# rails_env = ENV['RAILS_ENV'] || 'production'
# 
# # Log everything to one file
# stderr_path "/home/unicorn/log/unicorn.log"
# stdout_path "/home/unicorn/log/unicorn.log"
# 
# # Set master PID location
# pid "/home/unicorn/pids/unicorn.pid"
# 
# before_fork do |server, worker|
#   ActiveRecord::Base.connection.disconnect!
# 
#   old_pid = "#{server.config[:pid]}.oldbin"
#   if File.exists?(old_pid) && server.pid != old_pid
#     begin
#       Process.kill("QUIT", File.read(old_pid).to_i)
#     rescue Errno::ENOENT, Errno::ESRCH
#       # someone else did our job for us
#     end
#   end
# end
# 
# after_fork do |server, worker|
#   ActiveRecord::Base.establish_connection
# end