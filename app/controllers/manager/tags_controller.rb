

class Manager::TagsController < ManagerController

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new params[:tag]
    if @tag.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_tags_path
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
    @tags = Tag.all
  end
  
  def show
    @tag = Tag.where( :id => params[:id] ).first
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
    Tag.all.each {|t| t.remove }
    Report.all.each {|t| t.remove }
    flash[:notice] = t('g.done')
    redirect_to :action => :homepage
  end
  
end