

require 'reports_tasks'
require 'cities_tasks'

namespace :cities do
  
  desc 'to mongoid'
  task :to_mongoid => :environment do
    CitiesTasks.to_mongoid
  end
  
  desc 'attach reports to cities'
  task :attach_reports_to_cities => :environment do
    CitiesTasks.attach_reports_to_cities
  end
  
end

