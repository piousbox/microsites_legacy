
class DaysController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    @days = Day.all

    respond_to do |format|
      format.html
      format.json { render :json => @days }
    end
  end
  
  def search
    @day = Day.where( :date => params[:date] ).first
    if @day.blank?
      @day = Day.new
      render :action => :new
    else
      render :action => :edit
    end
  end
  
  def create
    # @todo I have to see that the days are unique
    
    day = Day.new params[:day]
    day.user = session[:current_user]
    
    if day.save
      flash[:notice] = 'Success'
      redirect_to :controller => :users, :action => :dashboard
    else
      flash[:error] = 'No luck'
      render :new
    end
    
    
  end
end
