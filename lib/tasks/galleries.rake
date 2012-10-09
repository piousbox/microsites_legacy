

require 'galleries_tasks'

namespace :galleries do
  
  desc "clean_name_seo"
  task :clean_name_seo => :environment do
    GalleriesTasks.clean_name_seo
  end
  
  
end

