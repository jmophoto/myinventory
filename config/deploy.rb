# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'inspeckd'
set :repo_url, 'git@github.com:jmophoto/inspeckd.git'
set :branch, 'inspeckd'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/inspeckd'
set :user, 'root'
set :ssh_options, { :forward_agent => true }

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command do
      on roles(:app), in: :sequence, wait: 5 do
        run "/etc/init.d/unicorn_#{application} #{command}"
      end
    end
  end

  task :setup_config do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
      sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
      run "mkdir -p #{shared_path}/config"
      put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
      puts "Now edit the config files in #{shared_path}."
    end
  end
  after "deploy", "deploy:setup_config"

  task :symlink_config do
    on roles(:app), in: :sequence, wait: 5 do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end
  after "deploy:finished", "deploy:symlink_config"

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
  before "deploy", "deploy:check_revision"
end