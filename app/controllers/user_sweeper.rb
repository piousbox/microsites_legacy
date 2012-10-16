

class UserSweeper < ActionController::Caching::Sweeper
  
  observe User
  observe UserProfile
 
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
    expire_page(:controller => 'users', :action => 'resume')
    
    # expire_page(:controller => 'users', :action => 'homepage')
    # expire_fragment('all_reports')
  end
  
end