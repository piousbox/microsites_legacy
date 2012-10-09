

require 'reports_tasks'

namespace :cities do
  
  desc 'to mongoid'
  task :to_mongoid => :environment do
    CitiesTasks.to_mongoid
  end
  
end

