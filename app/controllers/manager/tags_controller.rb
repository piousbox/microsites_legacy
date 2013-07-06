
class Manager::TagsController < Manager::ManagerController

  before_filter :sett_lists

  def new
    authorize! :new, ManagerTag.new
    @tag = Tag.new
  end

  def create
    params[:tag][:domain] = nil
    authorize! :create, ManagerTag.new

    @tag = Tag.new params[:tag]
    if @tag.save
      flash[:notice] = 'Manager Created Tag.'
    else
      flash[:error] = 'No Luck. ' + @tag.errors.inspect
    end

    if @tag.is_feature
      feature = Feature.new
      feature.name = @tag.name
      # feature.descr = @tag.descr
      feature.link_path = tag_path(@tag.name_seo)
      feature.subhead = 'New Tag'

      @site.features << feature
      @site.save
    end
    
    redirect_to manager_tags_path
  end
  
  def index
    authorize! :index, ManagerTag.new

    @tags = Tag.where( :parent_tag => nil ).order_by( :name => :asc )
  end
  
  def show
    authorize! :show, ManagerTag.new

    @tag = Tag.where( :id => params[:id] ).first
    @features = @tag.features
    @reports = @tag.reports.where( :is_trash => false ).order_by( :name => :desc ).page( params[:reports_page] )
    @galleries = Gallery.where( :tag => @tag).order_by( :created_at => :desc ).page( params[:galleries_page] )
  end

  def edit
    authorize! :edit, ManagerTag.new

    @tag = Tag.find params[:id]
    @tags_list = Tag.list
  end

  def update
    authorize! :update, ManagerTag.new

    @tag = Tag.find params[:id]
    if @tag.update_attributes params[:tag]
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_tags_path
  end
  
  def destroy
    authorize! :destroy, ManagerTag.new

    t = Tag.find params[:id]
    if t.remove
      flash[:notice] = 'Success'
    else
      flash[:errpr] = 'No Luck'
    end
    redirect_to manager_tags_path
  end
  
end
