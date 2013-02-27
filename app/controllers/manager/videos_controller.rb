
class Manager::VideosController < Manager::ManagerController

  def create
    @video = Video.new params[:video]
    @video.user = @current_user

    authorize! :create, @video

    if @video.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck. ' + @video.errors.to_s
    end

    ##
    ## newsitems
    ##
    if @video.is_public
      # for city
      if !@video.city_id.blank?
        @city = City.find(@video.city_id)
        n = Newsitem.new
        n.video = @video
        n.descr = @video.descr
        n.user = @video.user
        @city.newsitems << n
        if @city.save
        else
          flash[:error] = (flash[:error] || '') + 'City could not be saved (newsitem). '
        end
      end

      # for homepage
      n = Newsitem.new
      n.video = @video
      n.descr = @video.descr
      n.user = @video.user
      @site.newsitems << n
      if @site.save
      else
        flash[:error] = flash[:error] + 'City could not be saved (newsitem). '
      end
    end

    redirect_to manager_videos_path
  end

  def update
    @video = Video.find params[:id]
    authorize! :update, @video

    if @video.update_attributes params[:video]
      flash[:notice] = 'Success'
      redirect_to manager_videos_path
    else
      flash[:error] = 'No Luck. ' + @video.errors.to_s
      render :action => :edit
    end
  end

  def new
    @video = Video.new
    authorize! :new, @video
    @tags_list = Tag.list
    @cities_list = City.list

  end

  def edit
    @video = Video.find params[:id]
    authorize! :edit, @video
    @tags_list = Tag.list
    @cities_list = City.list

  end

  def destroy
    @video = Video.find params[:id]
    authorize! :delete, @video

    @video.is_trash = true
    if @video.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck. '
    end

    redirect_to manager_videos_path
  end

  def index
    @videos = Video.all

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
    @video = Video.where( :youtube_id => params[:youtube_id] ).first

    respond_to do |format|
      format.html
      format.json do
        render :json => @video
      end
    end
  end

end
