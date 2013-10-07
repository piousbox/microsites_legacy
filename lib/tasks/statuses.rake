

require 'statuses_tasks'

namespace :statuses do
  desc "Put all statuses into dictitems"
  task :to_dictitems => :environment do
    
    StatusesTasks.to_dictitems
    
  end
end

