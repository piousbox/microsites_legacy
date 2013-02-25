
class DaysController < ApplicationController

  def new
    authorize! :new, Day.new
    @day = Day.new
  end
  
  def index
    authorize! :index, Day.new
    @days = Day.where( :user => current_user )

    respond_to do |format|
      format.html
      format.json { render :json => @days }
    end
  end
  
  def create
    @day = Day.new params[:day]
    authorize! :new, @day
    @day.user = current_user
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
    authorize! :new, @day
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
    authorize! :search, Day.new
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
