
class UsersController < ApplicationController
  
  load_and_authorize_resource

  # caches_page :resume
  # cache_sweeper :user_sweeper

  def gallery
    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    @user = @gallery.user
    @title = "Gallery #{@gallery.name} of #{@user.username}"
    render :layout => 'resume'
  end

  def show

    if Rails.env.production? && 'piousbox.com' != @domain
      redirect_to "http://piousbox.com#{request.path}"
    elsif Rails.env.development? && 'pi.local' != @domain
      redirect_to "http://pi.local:3010#{request.path}"
    else
      @user = User.where( :username => params[:username] ).first
      if @user.blank?
        render :not_found
      else

        @profile = UserProfile.where( :user => @user, :lang => @locale ).first
        @title = "resume #{@user.username}"

        if params[:print]
          render :print, :layout => 'print'
        else
          render :layout => 'resume'
        end
      end
    end
  end
  
  def galleries
    @user = User.where( :username => params[:username] ).first
    tag = Tag.where( :name_seo => @user.username ).first
    @galleries = Gallery.all.where( :tag => tag ).page( params[:galleries_page] )
    @title = "Galleries of #{@user.username}"
    render :layout => 'resume'
  end

  def scratchpad
    s = params[:user][:scratchpad]
    @current_user.scratchpad = s
    if @current_user.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    redirect_to organizer_path
  end

  def report
    @report = Report.where( :name_seo => params[:name_seo] ).first
    @user = @report.user

    render :layout => 'resume'
    
  end

  def reports
    @user = User.where( :username => params[:username] ).first
    @tag = Tag.where( :name_seo => @user.username ).first
    if @tag.blank?
      flash[:notice] = 'This user has no characteristic tag.'
    end
    @reports = Report.all.where( :tag => @tag ).page( params[:reports_page] )

    respond_to do |format|
      format.html do
        render :layout => 'resume'
      end
      format.json do
        render :json => @reports
      end
    end
  end
  
  def account
    authorize! :account, User.new
    @user = @current_user
    render 'edit', :layout => 'organizer'
  end
  
  def index
    @title = 'All Users'
    @users = User

    unless params[:cityname].blank?
      city = City.where( :cityname => params[:cityname] ).first
      @users = @users.where( :city => city )
    end

    @users = @users.page( params[:users_page] )

    respond_to do |format|
      format.html do
        if '1' == @is_mobile
          render :layout => 'organizer'
        else
          render
        end
      end
      format.json do
        render :json => @users
      end
    end
  end
  
  def organizer
    # @reports = Report.where( :user => (current_user || session['current_user']) ).page(1)
    
    @newsitems = @current_user.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] )
    render :layout => 'organizer'
  end

  def update
    @user = User.find params[:id]
    old_group_id = @user.group_id
    authorize! :update, @user
    params[:user][:group_id] = old_group_id

    if @user.update_attributes params[:user]
      flash[:notice] = 'Success'
      redirect_to organizer_path
    else
      flash[:error] = 'No Luck. ' + @user.errors.inspect
      render :action => :edit
    end
    
  end
  
end
