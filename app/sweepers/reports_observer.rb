
class ReportsObserver < Mongoid::Observer

  observe :report

  def after_save report
    expire_cache report
  end

  def after_update report
    expire_cache report
  end

  private
 
  def expire_cache report
    @controller ||= ActionController::Base.new
    @controller.expire_action :controller => :reports, :action => :show, :name_seo => report.name_seo
    @controller.expire_action :controller => :reports, :action => :index
  end

end
