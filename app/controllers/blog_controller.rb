

class BlogController < ApplicationController
  
  def home
    @site = Site.where( :domain => @domain ).first
    @reports = Report.where( :domain => @domain ).page( params[:reports_page] )
  end
  
  def about
    ;
  end
  
  def privacy
    ;
  end
  
end