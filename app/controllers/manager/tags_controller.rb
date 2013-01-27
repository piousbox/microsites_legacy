
class Manager::TagsController < Manager::ManagerController

  def new
    @tag = Tag.new
  end

  def create
    new_domain = params[:tag][:domain]
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

      # @TODO the domain below should be set programmatically, not hardcoded
      site = Site.where( :domain => new_domain ).first
      
      site.features << feature
      if site.save
        ;
      else
        flash[:error] = "#{flash[:error]} Cannot save site feature. #{feature.errors.inspect}"
      end      
    end
    
    redirect_to manager_tags_path
  end
  
  def index
    @tags = Tag.all
  end
  
  def show
    @tag = Tag.where( :id => params[:id] ).first
    @reports = @tag.reports
    @galleries = @tag.galleries
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
    if t.remove
      flash[:notice] = 'Success'
    else
      flash[:errpr] = 'No Luck'
    end
    redirect_to manager_tags_path
  end
  
end