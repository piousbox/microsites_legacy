
require 'cgi'

class GalleriesTasks
  
  
  def self.clean_name_seo
    
    galleries = Gallery.find :all
    
    galleries.each do |g|
      
      Util.clean_name_seo g
      
    end
    
    
  end
  
end