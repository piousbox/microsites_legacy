
class DaysController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    @days = Day.where( :user => current_user )

    respond_to do |format|
      format.html
      format.json { render :json => @days }
    end
  end
  
  def create
    @day = Day.new params[:day]
    @day.user = current_user || session['current_user']
    if @day.save
      flash[:notice] = 'Success'
      redirect_to :controller => :users, :action => :organizer
    else
      flash[:error] = 'No Luck'
      render :action => :new
    end
  end
  
  def update
    @day = Day.where( :date => params[:day][:date] ).first
    @day.update_attributes( params[:day] )
    
    if @day.save
      flash[:notice] = 'Success'
      redirect_to :controller => :users, :action => :organizer
    else
      flash[:error] = 'No Luck'
      render :action => :new
    end
  end
  
  def search
    @day = Day.where( :date => params[:date], :user => current_user ).first
    
    if @day.blank?
      @day = Day.new
      @day.date = params[:date]
      render :action => :new
    else
      render :action => :edit
    end
  end
  
end
