
class Manager::SitesController < Manager::ManagerController

  def index
    @sites = Site.all
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new params[:site]
    if @site.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_sites_path
  end

  def edit
    @site = Site.find params[:id]
  end

  def update
    @site = Site.find params[:id]
    if @site.update_attributes params[:site]
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_sites_path
  end

  def destroy
    ;
  end

  def new_feature
    @site = Site.find params[:site_id]
    @feature = Feature.new
  end

  def create_feature
    @site = Site.find params[:site_id]
    @feature = Feature.new params[:feature]

    # new photo?

    @site.features << @feature

    if @site.save
      flash[:notice] = 'Success.'
      redirect_to :action => :index
      
    else
      flash[:error] = 'No Luck.'
      puts! @site.errors
      render :action => :new_feature

    end
    
  end

  def edit_feature
    @site = Site.find params[:site_id]
    @feature = @site.features.find params[:feature_id]
    
  end

  def update_feature
    @site = Site.find params[:site_id]
    @feature = @site.features.find params[:feature_id]
    if @feature.update_attributes params[:feature]
      flash[:notice] = 'Success'
      redirect_to manager_sites_path
    else
      flash[:error] = 'No Luck'
      puts! @feature.errors
      render :action => :edit_feature
    end
  end

  def new_newsitem
    ;
  end

  def create_newsitem
    ;
  end

end