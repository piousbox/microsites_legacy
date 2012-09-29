
module ApplicationHelper

  
  def second_tag_path t
    '#'
  end
  
  def search_path
    '/search'
  end
  
  def reports_path r
    return "/articles/#{r.name_seo}" unless r.name_seo.blank?
    super
    
  end
  
end

