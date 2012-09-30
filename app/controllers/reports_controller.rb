

class ReportsController < ApplicationController
  
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
  
end