

class VenuesController < ApplicationController

  load_and_authorize_resource
  
  def show
    @venue = Venue.where( :name_seo => params[:name_seo] ).first
    if @venue.blank?
      render :not_found
    else

      respond_to do |format|
        format.html do
          if @venue.city.blank?
            ;
          else
            #            @city = @venue.city
            #            load_features :cityname => @city.cityname
            #            render :layout => 'application_cities'
            ;
          end
        end
        format.json do
          render :json => @venue
        end
      end
    end
  end

  def index
    @venues = Venue.all.fresh

    unless params[:cityname].blank?
      @city = City.where( :cityname => params[:cityname] ).first
      @venues = @venues.where( :city => @city )
      layout = 'application_cities'

      @features = []
      @features << {
        :name => 'Feature Venue',
        :link_path => '/',
        :image_path => '/assets/missing.png',
        :subhead => 'Lorem ipsum blah ebedfg.'
      }
      @features << {
        :name => 'Greate Venue',
        :link_path => '/',
        :image_path => '/assets/missing.png',
        :subhead => 'Lorem ipsum blah ebedfg.'
      }
      @features << {
        :name => 'CAC',
        :link_path => '/',
        :image_path => '/assets/missing.png',
        :subhead => 'Lorem ipsum blah ebedfg.'
      }
      @features << {
        :name => 'Oppa!',
        :link_path => '/',
        :image_path => '/assets/missing.png',
        :subhead => 'Lorem ipsum blah ebedfg.'
      }
      
    else
      layout = 'application'
      
    end

    @venues = @venues.page( params[:venues_page] )

    respond_to do |format|
      format.html do
        render :layout => layout
      end
      format.json do
        render :json => @venues
      end
    end
  end
  
end