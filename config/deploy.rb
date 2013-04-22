load 'config/deploy_environments'
require "bundler/capistrano"
# require 'highline/import'

set :application, "microsites2"
set :repository,  "https://piousbox@bitbucket.org/piousbox/microsites2.git"
# set :git,  "git@bitbucket.org:piousbox/microsites2.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
ssh_options[:keys] = [
  File.join(ENV["HOME"], "projects", "rails-quick-start", "rails-quick-start.pem"),
  File.join(ENV["HOME"], ".ssh", "id_rsa_dell_user")
]
ssh_options[:port] = 2294

set :scm, 'git'
set :branch, 'master'
set :user, 'ubuntu'
set :app_user, "ubuntu"
# set :scm_passphrase, "puppy"
set :use_sudo, false
# set :password,         "grannie kiddie"


#
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "infiniteshelter.com"                          # This may be the same as your `Web` server
# role :db,  "infiniteshelter.com", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"x

desc "Zero-downtime restart of Unicorn"
task :restart, :except => { :no_release => true } do
  run "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
end

desc "Start unicorn"
task :start, :except => { :no_release => true } do
  run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D -E production"
end

desc "Stop unicorn"
task :stop, :except => { :no_release => true } do
  run "kill -s QUIT `cat #{shared_path}/pids/unicorn.pid`"
end

# kill -s QUIT `cat shared/pids/unicorn.pid`
# kill -s USR2 `cat shared/pids/unicorn.pid`    # restarts unicorn



#namespace :chef do
#  task :client, :roles => :app, :except => { :no_release => true } do
#    run "#{try_sudo} chef-client"
#  end
#end
#
#namespace :nginx do
#  task :restart, :roles => :app do
#    run "#{try_sudo} /etc/init.d/nginx restart && #{try_sudo} /etc/init.d/varnish restart"
#  end
#end
#
#namespace :deploy do
#  task :start do ; end
#  task :stop  do ; end
#
#  task :restart, :roles => :app, :except => { :no_release => true } do
#    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#  end
#
#  task :precompile, :roles => [ :app ] do
#    if 'production' == rails_env
#      run "cd #{deploy_to}/current && RAILS_ENV='#{rails_env}' bundle exec rake assets:precompile"
#    end
#  end
#
#  task :chown_project, :roles => [:app, :job] do
#    sudo "chmod 777 #{deploy_to}/releases"
#    sudo "chown -R #{app_user}:sysadmin #{deploy_to}"
#  end
#
#  task :seed, :roles => [ :app ] do
#    run "cd #{deploy_to}/current && RAILS_ENV='#{rails_env}' bundle exec rake db:seed"
#  end
#
#  #  task :symlink_database_config, :roles => [:app, :job] do
#  #    run "rm #{release_path}/config/database.yml"
#  #    run "ln -s #{deploy_to}/shared/database.yml #{release_path}/config/database.yml"
#  #  end
#
#
#end
#
#
# after 'deploy:setup',           'deploy:chown_project'
# after 'deploy',                 'deploy:chown_project'
# after 'deploy',                 'deploy:precompile'
# after 'deploy:finalize_update', 'deploy:symlink_database_config'
