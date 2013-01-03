

class VenuesController < ApplicationController

  load_and_authorize_resource
  
  def show
    @venue = Venue.where( :name_seo => params[:name_seo] ).first
    if @venue.blank?
      render :not_found
    else

      respond_to do |format|
        format.html
        format.json do
          render :json => @venue
        end
      end
    end
  end

  def index
    @v = Venue.all.fresh

    unless params[:cityname].blank?
      city = City.where( :cityname => params[:cityname] ).first
      @v = @v.where( :city => city )
    end

    @venues = @v.page( params[:venues_page] )

    respond_to do |format|
      format.html do
        ;
      end
      format.json do
        render :json => @venues
      end
    end
  end
  
end