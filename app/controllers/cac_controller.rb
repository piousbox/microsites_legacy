

class CacController < ApplicationController
  
  layout 'cac'

  load_and_authorize_resource
  
  before_filter :frt5
  
  def slider
    @data = []
    @data[0] = { :title => 'Computational Arts Corp.', :subtitle => 'Is a software engineering & 
consulting company.',
      :image => 'http://placehold.it/480x300'}
    @data[1] = { :title => 'Functional Correctness', :subtitle => 'We strive for make our software solutions 
fundamentally correct.',
      :image => 'http://placehold.it/480x300'}
    @data[2] = { :title => 'Developer efficiency', :subtitle => 'We optimize not for speed of execution, but for 
speed of development and cost of maintenance.', :image => 'http://placehold.it/480x300'}
    
    respond_to do |format|
      format.json do
        render :json => @data
      end
    end
  end

  def show
    @report = Report.where( :name_seo => params[:name_seo] ).first
  end

  
  def home
    ;
  end
  
  def news
    tag = Tag.where( :name_seo => 'cac' ).first
    @reports = Report.where( :tag => tag ).page( params[:reports_page] )
  end
  
  def about
    @tag = Tag.where( :name_seo => 'cac' ).first
  end
  
  def services
    ;
  end
  
  def team
    ;
  end
  
  def contact
    ;
  end
  
  private
  
  def frt5
    @subscription = Subscription.new
    @message = Message.new
    @posts = []
  end
  
end