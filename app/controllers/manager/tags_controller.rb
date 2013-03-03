
class Manager::TagsController < Manager::ManagerController

  def new
    @tag = Tag.new
  end

  def create
    params[:tag][:domain] = nil

    @tag = Tag.new params[:tag]
    @tag.user = @current_user
    if @tag.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck. ' + @tag.errors.inspect
    end

    if @tag.is_feature
      feature = Feature.new
      feature.name = @tag.name
      # feature.descr = @tag.descr
      feature.link_path = tag_path(@tag.name_seo)
      feature.tag = @tag

      @site.features << feature
      @site.save
    end
    
    redirect_to manager_tags_path
  end
  
  def index
    @tags = Tag.where( :is_trash => false )
  end
  
  def show
    @tag = Tag.where( :id => params[:id] ).first
    @reports = @tag.reports.where( :is_trash => false ).order_by( :name => :desc ).page( params[:reports_page] )
    @galleries = Gallery.where( :tag => @tag).order_by( :created_at => :desc ).page( params[:galleries_page] )
  end

  def edit
    @tag = Tag.find params[:id]
    @tags_list = Tag.list
  end

  def update
    @tag = Tag.find params[:id]
    if @tag.update_attributes params[:tag]
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_tags_path
  end
  
  def destroy
    t = Tag.find params[:id]
    if t.remove
      flash[:notice] = 'Success'
    else
      flash[:errpr] = 'No Luck'
    end
    redirect_to manager_tags_path
  end
  
end