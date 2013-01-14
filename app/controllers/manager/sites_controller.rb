
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
      flash[:error] = 'No Luck. ' + @site.errors.inspect
    end
    redirect_to manager_sites_path
  end

  def edit
    @site = Site.find params[:id]
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

    @site.save
    flash[:notice] = 'Dunno if success or not.'
    redirect_to :action => :index

  end

  def edit_feature
    @site = Site.find params[:site_id]
    @feature = @site.features.find params[:feature_id]
    
  end

  def update_feature
    @site = Site.find params[:site_id]
    @feature = @site.features.find params[:feature_id]
    if @feature.update_attributes params[:feature] && @site.save
      flash[:notice] = 'Success'
      redirect_to manager_sites_path
    else
      flash[:error] = 'No Luck. ' + @site.errors.inspect
      render :action => :edit_feature
    end
  end

  def new_newsitem
    @newsitem = Newsitem.new
    @site = Site.find params[:site_id]

    fffind
    
  end

  def create_newsitem
    @site = Site.find params[:site_id]

    unless params[:newsitem][:report_id].blank?
      n = Newsitem.new params[:newsitem]
      n.report = Report.find params[:newsitem][:report_id]
      n.username = params[:newsitem][:username]
      n.descr = params[:newsitem][:descr]
      @site.newsitems << n
    end

    unless params[:newsitem][:gallery_id].blank?
      n = Newsitem.new params[:newsitem]
      n.gallery = Gallery.find params[:newsitem][:gallery_id]
      n.username = params[:newsitem][:username]
      n.descr = params[:newsitem][:descr]
      @site.newsitems << n
    end

    fffind

    @site.save
    flash[:notice] = 'Dunno if success or not.'
    redirect_to edit_manager_site_path( @site.id )
    
  end

  private

  def fffind
    @list_reports = Report.all.fresh.public.list
    @list_galleries = Gallery.all.fresh.public.list
    @list_users = [['', nil]] + User.all.order_by( :name => :asc ).map { |u| [u.username, u.username] }
  end

end