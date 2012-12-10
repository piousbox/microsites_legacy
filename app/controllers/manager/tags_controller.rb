

class Manager::TagsController < ManagerController

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new params[:tag]
    @tag.user = @current_user
    if @tag.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_tags_path
  end
  
  def index
    @tags = Tag.all.fresh
  end
  
  def show
    @tag = Tag.where( :id => params[:id] ).first
    @reports = @tag.reports.fresh
    @galleries = @tag.galleries.fresh
  end

  def edit
    @tag = Tag.find params[:id]
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
    flash[:notice] = t('g.done')
    redirect_to :action => :homepage
  end
  
end