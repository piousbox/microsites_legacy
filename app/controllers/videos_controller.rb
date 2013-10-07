
class VideosController < ApplicationController
  
  caches_page :index, self::CACHE_OPTIONS
  caches_page :show, self::CACHE_OPTIONS

  def index
    authorize! :index, Video.new
    @videos = Video.all

    if params[:cityname]
      city = City.where( :cityname => params[:cityname] ).first
      @videos = @videos.where( :city => city )
    end

    if params[:tagname]
      tag = Tag.where( :name_seo => params[:tagname] ).first
      @videos = @videos.where( :tag => tag )
    end
    
    @videos = @videos.page( params[:videos_page] ).per( Video::PER_PAGE )

    respond_to do |format|
      format.html do
        render
      end
      format.json do
        render :json => @videos
      end
    end
  end

  def show
    @video = Video.where( :youtube_id => params[:youtube_id] ).first
    authorize! :show, @video

    respond_to do |format|
      format.html
      format.json do
        render :json => @video
      end
    end
  end

  def new
    @video = Video.new
    authorize! :new, @video
 
    @tags_list = Tag.list
    @cities_list = City.list
  end

  def create
    @video = Video.new params[:video]
    @video.user = current_user
    @video.site = @site unless params[:video][:site_id]
    authorize! :create, @video
    
    if @video.save
      flash[:notice] = 'Success'
      
      expire_page :controller => 'sites', :action => 'show', :domainname => @site.domain
      expire_page :controller => 'videos', :action => 'index'

      redirect_to organizer_path
    else
      flash[:error] = 'No luck'
      @tags_list = Tag.list
      @cities_list = City.list
      render :action => 'new'
    end
  end
  
end
