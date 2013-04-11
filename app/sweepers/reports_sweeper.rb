
class ReportsSweeper < ActionController::Caching::Sweeper

  observe Report
  
  def after_create report
    expire_cache_for report
  end

  def after_update report
    expire_cache_for report
  end

  private

  def expire_cache_for report
    expire_page :controller => :reports, :action => :index
    expire_page :controller => :sites, :action => :show, :domainname => 'pi'
    expire_page :controller => :reports, :action => :show, :name_seo => report.name_seo
  end

end
