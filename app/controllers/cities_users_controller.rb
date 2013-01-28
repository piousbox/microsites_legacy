
class CitiesUsersController < ApplicationController

  layout 'organizer'

  before_filter :set_new_for_organizer
  
  def index
    authorize! :index, CitiesUser.new
    @cities_users = CitiesUser.where( :user => @current_user ).order_by( :date => :desc )
    
  end

  def search
    authorize! :search, CitiesUser.new
  end

  def show
    ;
  end

  def new
    @cities_user = CitiesUser.new
    authorize! :new, @cities_user

    @cities_list = City.all.list
    
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