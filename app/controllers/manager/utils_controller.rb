
class Manager::UtilsController < Manager::ManagerController

  def expire_cache
    Rails.cache.clear

    flash[:notice] = 'All Done.'
    redirect_to :controller => 'manager/welcome', :action => :homepage
  end

end
