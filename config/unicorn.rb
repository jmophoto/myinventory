listen "/tmp/unicorn.myinventory.sock"
worker_processes 2
user "rails"
working_directory "/home/myinventory/current"
pid "/home/unicorn/pids/unicorn.pid"
stderr_path "/home/unicorn/log/unicorn.log"
stdout_path "/home/unicorn/log/unicorn.log"