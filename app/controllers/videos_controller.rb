

class VideosController < ApplicationController

  load_and_authorize_resource
  
  def index
    @videos = Video.all.fresh.public

    if params[:cityname]
      city = City.where( :cityname => params[:cityname] ).first
      @videos = @videos.where( :city => city )
    end

    @videos = @videos.page( params[:videos_page] )

    respond_to do |format|
      format.html
      format.json do
        render :json => @videos
      end
    end
  end

  def show
    ;
  end
  
end