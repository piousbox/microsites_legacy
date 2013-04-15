class Manager::SitesController < Manager::ManagerController
  def index
    @sites = Site.where( :is_trash => false ).order_by( :lang => :desc )
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new params[:site]
    if @site.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck. ' + @site.errors.inspect
    end
    redirect_to manager_sites_path
  end

  def edit
    @site = Site.find params[:id]
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse[0...8]
    @newsitems = @site.newsitems.order_by( :created_at => :desc ).page( params[:newsitems_page] )
  end

  def show
    @site = Site.find params[:id]
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse[0...(@site.n_features*2)]
    @newsitems = @site.newsitems.order_by( :created_at => :desc ).page( params[:newsitems_page] )
  end

  def update
    @site = Site.find params[:id]
    if @site.update_attributes params[:site]
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck. ' + @site.errors.inspect
    end
    redirect_to manager_sites_path
  end

  def destroy
    @site = Site.find params[:id]
    @site.is_trash = true
    if @site.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck.'
    end
    redirect_to manager_sites_path
  end

  def new_feature
    @site = Site.find params[:site_id]
    @feature = Feature.new
    @reports_list = Report.list( :is_trash => false, :is_public => true )
    @galleries_list = Gallery.all.list
    @cities_list = City.all.list
  end

  def create_feature
    @site = Site.find params[:site_id]
    @feature = Feature.new params[:feature]
    @reports = Report.list( :is_trash => false, :is_public => true )
    
    # new photo?

    @site.features << @feature

    @site.save
    flash[:notice] = 'Dunno if success or not.'
    redirect_to :action => :index
  end

  def edit_feature
    @site = Site.find params[:site_id]
    @feature = @site.features.find params[:feature_id]
    @reports = Report.list( :is_trash => false, :is_public => true )
  end

  def update_feature
    @site = Site.find params[:site_id]
    @feature = @site.features.find params[:feature_id]
    @reports = Report.list( :is_trash => false, :is_public => true )

    if @feature.update_attributes( params[:feature] )
      flash[:notice] = 'Success'
      redirect_to edit_manager_site_path(@site.id)
    else
      flash[:error] = 'No Luck. ' + @site.errors.inspect
      render :action => :edit_feature
    end
  end

  def destroy_feature
    site = Site.find params[:site_id]
    feature = site.features.find params[:feature_id]
    if feature.remove
      flash[:notice] = 'Success.'
    else
      flash[:error] = 'No Luck.'
    end
    redirect_to manager_site_path(params[:site_id])
    
  end

  def feature_show
    ;
  end

  def new_newsitem
    @newsitem = Newsitem.new
    @site = Site.find params[:site_id]
    fffind
  end

  def create_newsitem
    @site = Site.find params[:site_id]

    if !params[:newsitem][:report_id].blank?
      n = Newsitem.new params[:newsitem]
      n.report = Report.find params[:newsitem][:report_id]
      n.username = params[:newsitem][:username]
      n.descr = params[:newsitem][:descr]
      @site.newsitems << n
    elsif !params[:newsitem][:gallery_id].blank?
      n = Newsitem.new params[:newsitem]
      n.gallery = Gallery.find params[:newsitem][:gallery_id]
      n.username = params[:newsitem][:username]
      n.descr = params[:newsitem][:descr]
      @site.newsitems << n
    else
      n = Newsitem.new params[:newsitem]
      n.descr = params[:newsitem][:descr]
      @site.newsitems << n
    end

    fffind

    @site.save
    flash[:notice] = 'Dunno if success or not.'
    redirect_to edit_manager_site_path( @site.id )
  end

  def newsitem_destroy
    site = Site.find params[:site_id]
    newsitem = site.newsitems.find params[:newsitem_id]
    newsitem.remove
    site.save
    flash[:notice] = 'Mmmaybe'
    
    redirect_to manager_site_path(site)
  end
  
  ##
  ## private begins
  ##
  private

  def fffind
    @list_reports = Report.all.public.list
    @list_galleries = Gallery.all.public.list
    @list_users = [['', nil]] + User.all.order_by( :name => :asc ).map { |u| [u.username, u.username] }
  end
end
