

#desc "Deploy to dev (usage: cap dev deploy)"
#task :dev do
#  set :domain,      "dev-stylesignup.tgtapps.com"
#  set :rails_env,   "dev"
#  # set :deploy_to,   "/var/www/stylesignup"
#  set :deploy_to, '/var/www/origin-dev-stylesignup.tgtapps.com'
#
#
#  #  role :app,        "50.57.228.103"
#  #  role :app,        "50.57.229.6"
#
#  role :app,        "50.56.28.162"
#  role :app,        "184.106.178.109"
#
#  # role :db,         "50.57.228.103", :primary => true
#end
#
#desc "Deploy to staging (usage: cap staging deploy)"
#task :staging do
#  set :domain,      "staging-stylesignup.tgtapps.com"
#  set :rails_env,   "staging"
#  # set :deploy_to,   "/var/www/stylesignup"
#  set :deploy_to, "/var/www/origin-staging-stylesignup.tgtapps.com"
#
#  role :app,        "50.57.171.141"
#  role :app,        "50.57.49.93"
#
#  # used to be production
#  # role :app,        "108.166.124.220"
#  # role :app,        "108.166.124.224"
#  # role :db,         "108.166.124.220", :primary => true
#end

desc "Deploy to production (usage: cap production deploy)"
task :production do
  set :domain,      "infiniteshelter.com"
  set :rails_env,   "production"
  set :deploy_to,   "/home/ubuntu/projects/microsites3"

  role :app,        "infiniteshelter.com"
  # role :app,        "50.56.33.195"
  # role :app,        "50.57.111.162"
  #
  # role :app,        "50.57.220.179"
  # role :app,        "108.166.124.65"
  # role :db,        "108.166.124.65", :primary => true
end
