
class Manager::UtilsController < Manager::ManagerController

  def expire_cache
    expire_page :controller => 'welcome', :action => 'home'
  end

end
