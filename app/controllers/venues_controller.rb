
class VenuesController < ApplicationController

  load_and_authorize_resource
  
  def show
    if @venue = Venue.where( :name_seo => params[:name_seo] ).first
      @reports = @venue.reports.all.page( params[:reports_page] )
      @newsitems = @site.newsitems.all.page( params[:newsitems_page] ) # @venue.newsitems.page( params[:newsitems_page] )
      @features = @site.features.all.limit( Feature.n_features ) # @venue.features.all.limit( Feature.n_features )

      @ch_tag = Tag.where( :name_seo => @venue.name_seo ).first
      @ch_links = [] # ch-reports
      @ch_links << { :name => t('g.news'), :path => venue_news_path(@venue.name_seo) }
      @reports.each do |r|
        @ch_links << { :name => r.name, :path => report_path(r.name_seo) }
      end
      @ch_gallery = Gallery.where( :tag => @ch_tag ).first

      respond_to do |format|
        format.html do
          render :layout => 'application_mini'
        end
        format.json do
          render :json => @venue
        end
      end
    else
      render :not_found
    end
  end

  def index
    @venues = Venue.all

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
        @venues = @venues.to_a
        @venues.each_with_index do |v, idx|
          @venues[idx][:photo_url_thumb] = v.profile_photo.blank? ? '/assets/missing.png' : v.profile_photo.photo.url(:thumb)
          @venues[idx][:path] = venue_path(v.name_seo)
        end

        render :json => @venues
        
      end
    end
  end
  
end