
class VenuesController < ApplicationController

  def show
    if @venue = Venue.where( :name_seo => params[:name_seo] ).first
      authorize! :show, @venue
      set_ch
      
      respond_to do |format|
        format.html do
          render :layout => params[:layout]
        end
        format.json do
          render :json => @venue
        end
      end
    else
      authorize! :not_found, Venue.new
      render :not_found
    end
  end

  def index
    @venues = Venue.all
    authorize! :index, Venue.new

    if params[:cityname].blank?

    else
      @city = City.where( :cityname => params[:cityname] ).first
      @venues = @venues.where( :city => @city )
      
    end

    @venues = @venues.page( params[:venues_page] )

    respond_to do |format|
      format.html do
        render :layout => @layout
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

  def news
    if @venue = Venue.where( :name_seo => params[:name_seo] ).first
      set_ch
      authorize! :news, @venue

      respond_to do |format|
        format.html do
          render
        end
        format.json do
          render :json => @venue
        end
      end
    else
      authorize! :not_found, Venue.new
      render :not_found
    end
  end

  def report
    @venue = Venue.where( :name_seo => params[:venuename] ).first
    @report = Report.where( :name_seo => params[:reportname] ).first
    authorize! :show, @report
    set_ch
  end

  def new
    @venue = Venue.new
    authorize! :new, @venue
    render :layout => @layout
  end

  def create
    @venue = Venue.new params[:venue]
    authorize! :create, @venue

    # @venue.name_seo ||= @venue.name.to_simple_string
    @venue.is_public = true
    @venue.owner = @current_user

    if @venue.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to venues_in_city_path(City.find(@venue.city_id).cityname)
  end

  def gallery
    @venue = Venue.where( :name_seo => params[:venuename] ).first
    @featues = @venue.features
    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    @photos = @gallery.photos
    authorize! :show, @gallery
    set_ch
    render :layout => @layout
  end

  ##
  ## private
  ##
  private

  def set_ch
    @reports = @venue.reports.all.page( params[:reports_page] )
    @galleries = @venue.galleries.all.page( params[:galleries_page] )
    @users = @venue.users.all.page( params[:users_page] )

    @newsitems = @venue.newsitems.all.page( params[:newsitems_page] ) # @venue.newsitems.page( params[:newsitems_page] )
    @features = @venue.features.all
 
    @ch_tag = Tag.where( :name_seo => @venue.name_seo ).first

    @ch_links = [] # ch-reports
    @ch_links << { :name => t('g.news'), :path => venue_news_path(@venue.name_seo), :class => 'news' }
    @reports.each do |r|
      @ch_links << { :name => r.name, :path => venue_report_path({ 
            :reportname => r.name_seo, :venuename => @venue.name_seo
          }), :class => r.name_seo }
    end
    @ch_gallery = Gallery.where( :tag => @ch_tag ).first
    
  end
  
end
