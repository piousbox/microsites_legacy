
class Manager::UsersController < Manager::ManagerController
 
  def edit
    authorize! :edit, ManagerUser

    @user = User.find params[:id]
    @venues_list = Venue.all.list
  end

  def update
    authorize! :update, ManagerUser

    @user = User.find params[:id]
    if @user.update_attributes params[:user]
      flash[:notice] = 'Success'
      redirect_to manager_users_path
    else
      flash[:error] = @user.errors.inspect
      render :edit
    end

  end

  def index
    authorize! :index, ManagerUser

    @users = User.all
  end

end
