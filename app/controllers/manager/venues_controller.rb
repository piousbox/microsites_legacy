



class Manager::VenuesController < ManagerController

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
    ;
  end
  
  def update
    ;
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