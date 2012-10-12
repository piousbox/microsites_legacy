

class Manager::TagsController < ManagerController
  
  def index
    @tags = Tag.all
  end
  
  def show
    @tag = Tag.where( :id => params[:id] ).first
  end
  
  def destroy
    Tag.all.each {|t| t.remove }
    Report.all.each {|t| t.remove }
    flash[:notice] = t('g.done')
    redirect_to :action => :homepage
  end
  
end