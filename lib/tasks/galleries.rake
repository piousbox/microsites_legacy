

require 'galleries_tasks'

namespace :galleries do
  
  desc "clean_name_seo"
  task :clean_name_seo => :environment do
    GalleriesTasks.clean_name_seo
  end
  
  desc 'rake galleries:to_photo_names'
  task :to_photo_names => :environment do
    GalleriesTasks.to_photo_names
  end

  desc 'to_mongoid'
  task :to_mongoid => :environment do
    GalleriesTasks.to_mongoid
  end
  
end

