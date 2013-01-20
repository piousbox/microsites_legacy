
class Manager::VenuesController < Manager::ManagerController

  def show
    @venue = Venue.find( params[:id] )
    @reports = @venue.reports.all.page( params[:reports_page] )
    @galleries = @venue.galleries.all.page( params[:galleries_page] )
    @photos = @venue.photos.all.page( params[:photos_page] )

    @n_features = @venue.features.length
    @n_newsitems = @venue.newsitems.length

    @ch_tag = Tag.where( :name_seo => @venue.name_seo ).first
    @ch_gallery = Gallery.where( :tag => @ch_tag ).first
    @ch_report = Report.where( :name_seo => @venue.name_seo ).first
    
    respond_to do |format|
      format.html do
        render
      end
    end
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create params[:venue]
    @venue.user = current_user

    if @venue.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_venues_path
  end

  def edit
    @venue = Venue.find( params[:id] )
  end
  
  def update
    @v = Venue.find params[:id]
    @v.update_attributes params[:venue]
    if @v.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_venues_path
  end

  def index
    @venues = Venue.all.fresh
    
    respond_to do |format|
      format.html
      format.json do
        render :json => []
      end
    end
  end

  def destroy
    ;
  end

end