set :application, "set your application name here"
set :repository,  "set your repository location here"

set :scm, 'git'
set :git, 'https://piousbox@bitbucket.org/piousbox/microsites2.git'
set :branch, 'master'

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "infiniteshelter.com"                          # This may be the same as your `Web` server
# role :db,  "infiniteshelter.com", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

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