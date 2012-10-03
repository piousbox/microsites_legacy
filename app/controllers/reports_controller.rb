

class ReportsController < ApplicationController
  
  caches_page :index
  caches_page :homepage
  caches_page :show
  cache_sweeper :report_sweeper
  
  def homepage
    @reports = Report.for_homepage :main_tag => @main_tag,
      :page => params[:page]
    
  end
  
  def index
    ;
  end
  
  def show
    
    unless params[:name_seo].blank?
      @report = Report.where( :name_seo => params[:name_seo] ).first
    else
      @report = Report.find params[:id]
    end
    
  end
  
  private
  
end