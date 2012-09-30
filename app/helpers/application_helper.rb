
module ApplicationHelper

  def admin_path
    '/admin'
  end
  
  def second_tag_path t
    return "/tags/view/#{t[:name_seo]}" unless t[:name_seo].blank?
    
    "/tags/#{t.to_param}"
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

