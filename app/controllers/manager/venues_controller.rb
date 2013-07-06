
class Manager::VenuesController < Manager::ManagerController

  def show
    authorize! :show, ManagerVenue

    @venue = Venue.find( params[:id] )
    @reports = @venue.reports.all.page( params[:reports_page] )
    @galleries = @venue.galleries.all.page( params[:galleries_page] )
    @photos = @venue.photos.all.page( params[:photos_page] )

    @n_features = @venue.features.all.where( :is_feature => true ).length
    @n_newsitems = @venue.newsitems.all.length

    @ch_tag = Tag.where( :name_seo => @venue.name_seo ).first
    @ch_gallery = Gallery.where( :tag => @ch_tag ).first
    @ch_report = Report.where( :name_seo => @venue.name_seo ).first

    @newsitems = @venue.newsitems.all.page( params[:newsitems_page] )
    
    respond_to do |format|
      format.html do
        render
      end
    end
  end

  def new
    authorize! :new, ManagerVenue

    @venue = Venue.new
  end

  def create
    authorize! :create, ManagerVenue

    @venue = Venue.create params[:venue]
    @venue.owner = @current_user
    
    if @venue.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_venues_path
  end

  def edit
    authorize! :edit, ManagerVenue

    @venue = Venue.find( params[:id] )
  end
  
  def update
    authorize! :update, ManagerVenue

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
    authorize! :index, ManagerVenue

    @venues = Venue.all
    
    respond_to do |format|
      format.html
      format.json do
        render :json => []
      end
    end
  end

  def destroy
    authorize! :destroy, ManagerVenue
  end

  def new_feature
    authorize! :new_feature, ManagerVenue

    @venue = Venue.where( :name_seo => params[:name_seo] ).first
    @feature = Feature.new
  end

  def create_feature
    authorize! :create_feature, ManagerVenue

    @venue = Venue.where( :name_seo => params[:name_seo] ).first
    @feature = Feature.new params[:feature]
    @venue.features << @feature
    if @venue.save
      flash[:notice] = 'Success'
      redirect_to :action => :show, :id => @venue.id
    else
      flash[:error] = 'No Luck. ' + @venue.errors
      render :action => :new_feature
    end
  end

  def edit_feature
    authorize! :edit_feature, ManagerVenue

    @venue = Venue.where( :name_seo => params[:name_seo] ).first
    @feature = @venue.features.find( params[:id] )
  end

  def update_feature
    authorize! :update_feature, ManagerVenue

    @venue = Venue.where( :name_seo => params[:name_seo] ).first
    @feature = @venue.features.find( params[:id] )
    @feature.update_attributes params[:feature]
    if @venue.save
      flash[:notice] = 'Success'
      redirect_to :action => :show, :id => @venue.id
    else
      flash[:error] = 'No Luck. ' + @venue.errors
      render :action => :new_feature
    end
  end

  def new_newsitem
    authorize! :new_newsitem, ManagerVenue

    @venue = Venue.where( :name_seo => params[:name_seo] ).first
    @newsitem = Newsitem.new
  end

  def create_newsitem
    authorize! :create_newsitem, ManagerVenue

    @venue = Venue.where( :name_seo => params[:name_seo] ).first
    n = Newsitem.from_params params[:newsitem]
    @venue.newsitems << n
    if @venue.save
      flash[:notice] = 'Success'
      redirect_to :action => :show, :id => @venue.id
    else
      flash[:error] = 'No Luck. ' + @venue.errors
      render :action => :new_feature
    end
  end
end
