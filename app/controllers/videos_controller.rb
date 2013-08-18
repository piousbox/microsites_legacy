
class VideosController < ApplicationController
  
  caches_page :index, self::CACHE_OPTIONS
  caches_page :show, self::CACHE_OPTIONS

  def index
    authorize! :index, Video.new
    @videos = Video.all.public

    if params[:cityname]
      city = City.where( :cityname => params[:cityname] ).first
      @videos = @videos.where( :city => city )
    end

    if params[:tagname]
      tag = Tag.where( :name_seo => params[:tagname] ).first
      @videos = @videos.where( :tag => tag )
    end
    
    @videos = @videos.page( params[:videos_page] )

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
  
end
