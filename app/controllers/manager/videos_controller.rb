
class Manager::VideosController < Manager::ManagerController

  load_and_authorize_resource

  def create
    @video = Video.new params[:video]
    @video.user = @current_user

    if @video.save
      flash[:notice] = 'Success'
      redirect_to manager_videos_path
    else
      flash[:error] = 'No Luck. ' + @video.errors.to_s
      render :action => :new
    end
  end

  def update
    @video = Video.find params[:id]
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
    @tags_list = Tag.list
    
  end

  def edit
    @video = Video.find params[:id]
    @tags_list = Tag.list

  end

  def destroy
    ;
  end

  def index
    @videos = Video.all.fresh

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