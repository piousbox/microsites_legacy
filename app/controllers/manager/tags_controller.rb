

class Manager::TagsController < Manager::ManagerController

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
    t = Tag.find params[:id]
    t.is_trash = true
    if t.save
      flash[:notice] = 'Success'
    else
      flash[:errpr] = 'No Luck'
    end
    redirect_to manager_tags_path
  end
  
end