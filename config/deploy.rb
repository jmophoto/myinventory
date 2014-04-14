# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'myinventory'
set :repo_url, 'git@github.com:jmophoto/myinventory.git'
set :branch, 'master'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/myinventory'
set :user, 'root'
set :ssh_options, { :forward_agent => true }

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command do
      on roles(:app), in: :sequence, wait: 5 do
        execute "service unicorn_myinventory restart"
      end
    end
  end
  after "deploy", "deploy:restart"

  task :setup_config do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/myinventory"
      sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_myinventory"
    end
  end
  after "deploy:check", "deploy:setup_config"

  task :symlink_config do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      sudo "ln -nfs #{shared_path}/config/authorize_net.yml #{release_path}/config/authorize_net.yml"
      sudo "ln -nfs #{shared_path}/public/images #{release_path}/public/images"
    end
  end
  before "deploy:assets:precompile", "deploy:symlink_config"
  
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app), in: :sequence, wait: 5 do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end
  # before "deploy", "deploy:check_revision"
end