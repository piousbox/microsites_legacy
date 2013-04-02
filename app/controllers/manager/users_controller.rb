
class Manager::UsersController < Manager::ManagerController
 
  def edit
    @user = User.find params[:id]
    @venues_list = Venue.all.list
  end

  def update
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
    @users = User.all

  end

end
