

class BlogController < ApplicationController
  
  def home
    @site = Site.where( :domain => @domain ).first
    @reports = Report.where( :domain => @domain ).sort( :created_at => :desc ) # .page( params[:reports_page] )
    render :layout => 'blog'
  end
  
  def about
    ;
  end
  
  def privacy
    ;
  end
  
end