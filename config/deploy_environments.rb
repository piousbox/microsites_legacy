
desc "Deploy to staging (usage: cap staging deploy)"
task :staging do
  set :domain,      "staging.piousbox.com"
  set :rails_env,   "staging"
  set :deploy_to, "/home/ubuntu/projects/microsites2_staging"
  set :branch, 'staging'
  set :use_sudo, true

  role :app,        "infiniteshelter.com:2294"

#  role :app,        "50.57.49.93"

end

#desc "Deploy to production (usage: cap production deploy)"
#task :production do
#  set :domain,      "infiniteshelter.com"
#  set :rails_env,   "production"
#  set :deploy_to,   "/home/ubuntu/projects/microsites3"
#
#  role :app,        "infiniteshelter.com"
#  # role :app,        "50.56.33.195"
#  # role :app,        "50.57.111.162"
#  #
#  # role :app,        "50.57.220.179"
#  # role :app,        "108.166.124.65"
#  # role :db,        "108.166.124.65", :primary => true
#end

#desc 'tasks for environment staging'
#task :staging do
#  set :domain, 'staging.piousbox.com'
#  set :rails_env, 'staging'
#  set :deploy_to, '/home/ubuntu/projects/microsites2_staging'
#  
#  role :app, 'staging.piousbox.com'
#end
