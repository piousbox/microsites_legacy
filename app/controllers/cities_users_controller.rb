
class CitiesUsersController < ApplicationController
  
  def index
    authorize! :index, CitiesUser.new
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
    ;
  end

  def edit
    ;
  end

  def update
    ;
  end
  
end