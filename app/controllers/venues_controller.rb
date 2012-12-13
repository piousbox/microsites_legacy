

class VenuesController < ApplicationController

  load_and_authorize_resource
  
  def show
    ;
  end

  def index

    respond_to do |format|
      format.json do
        render :json => []
      end
    end
  end
  
end