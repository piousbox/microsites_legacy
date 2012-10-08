

class BlogController < ApplicationController
  
  def home
    @reports = Report.for_homepage :main_tag => @main_tag,
      :page => params[:page]
  end
  
  def about
    ;
  end
  
  def privacy
    ;
  end
  
end