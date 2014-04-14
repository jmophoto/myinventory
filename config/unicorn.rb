listen "/tmp/unicorn.myinventory.sock"
worker_processes 2
user "rails"
working_directory "/home/myinventory/current"
pid "/home/unicorn/pids/myinventory.pid"
stderr_path "/home/unicorn/log/myinventory.log"
stdout_path "/home/unicorn/log/myinventory.log"
