

class ReportSweeper < ActionController::Caching::Sweeper
  
  observe Report
 
  def after_create(product)
    expire_cache_for(product)
  end
 
  def after_update(product)
    expire_cache_for(product)
  end
 
  def after_destroy(product)
    expire_cache_for(product)
  end
 
  private
  
  def expire_cache_for(product)
    expire_page(:controller => 'reports', :action => 'index')
    expire_page(:controller => 'reports', :action => 'homepage')
 
    # expire_fragment('all_reports')
  end
  
end