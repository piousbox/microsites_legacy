
class Manager::VenuesController < Manager::ManagerController

  def show
    ;
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create params[:venue]
    @venue.user = current_user

    if @venue.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_venues_path
  end

  def edit
    @venue = Venue.find( params[:id] )
  end
  
  def update
    @v = Venue.find params[:id]
    @v.update_attributes params[:venue]
    if @v.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to manager_venues_path
  end

  def index
    @venues = Venue.all.fresh
    
    respond_to do |format|
      format.html
      format.json do
        render :json => []
      end
    end
  end

  def destroy
    ;
  end

end