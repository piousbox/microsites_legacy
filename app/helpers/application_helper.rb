
module ApplicationHelper

  
  def second_tag_path t
    '#'
  end
  
  def search_path
    '/search'
  end
  
  def report_path r
    return "/articles/read/#{r[:name_seo]}" unless r[:name_seo].blank?
    
    "/articles/#{r[:_id]}"
  end
  
  def manager_path
    '/manager'
  end
  
end

