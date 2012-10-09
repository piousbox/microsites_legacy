

require 'tags_tasks'

namespace :tags do
  
  desc " put from sql to mongoid "
  task :to_mongoid => :environment do
    TagsTasks.to_mongodb
    
  end
  
  
end

