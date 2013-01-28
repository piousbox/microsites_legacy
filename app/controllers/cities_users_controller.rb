
class CitiesUsersController < ApplicationController

  layout 'organizer'
  
  def index
    authorize! :index, CitiesUser.new
    @cities_users = CitiesUser.where( :user => @current_user )
    
  end

  def search
    authorize! :search, CitiesUser.new
  end

  def show
    ;
  end

  def new
    authorize! :new, CitiesUser.new
  end

  def create
    @cities_user = CitiesUser.new params[:cities_user]
    @cities_user.user = @current_user
    authorize! :create, @cities_user

    if @cities_user.save
      ;
    else
      ;
    end
    
    redirect_to :action => :index
  end

  def edit
    ;
  end

  def update
    ;
  end
  
end