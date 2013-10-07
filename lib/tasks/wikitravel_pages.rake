require 'wikitravel_tasks'
namespace :wikitravel do
  
  desc "Usage: be rake wikitravel:random_page_to_newsitem domain='mobi.local'"
  task :random_page_to_newsitem => :environment do
    # takes too long
    WikitravelTasks.parse_list_of_pages
    
    WikitravelTasks.random_page_to_newsitem ENV['domain']
  end
  
  desc 'parse list of pages'
  task :parse_list_of_pages => :environment do
    WikitravelTasks.parse_list_of_pages
  end

end

