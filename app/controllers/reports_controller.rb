

class ReportsController < ApplicationController
  
  caches_page :index
  caches_page :homepage
  caches_page :show
  cache_sweeper :report_sweeper
  
  def homepage
    @reports = Report.for_homepage :main_tag => @main_tag,
      :page => params[:page]
    
  end
  
  def search
    render :action => :index
    
  end
  
  def index
    @reports = Report.page( params[:reports_page] )
    
    respond_to do |format|
      
      format.html do
        render :layout => false
      end
      
      format.json do
        render :json => @reports
      end
      
    end
  end
  
  def show
    
    unless params[:name_seo].blank?
      @report = Report.where( :name_seo => params[:name_seo] ).first
    else
      @report = Report.find params[:id]
    end
    
    respond_to do |format|
      format.html do
        render :layout => 'blog'
      end
      
      format.json do
        render :json => @report
      end
    end
    
  end
  
  private
  
end