
module ApplicationHelper

  
  def second_tag_path t
    '#'
  end
  
  def search_path
    '/search'
  end
  
  def reports_path r
    return report_path(r) unless r[:name_seo].blank?
    super
  end
  
  def report_path r
    return "/articles/#{r[:name_seo]}" unless r[:name_seo].blank?
  end
  
  def manager_path
    '/manager'
  end
  
end

