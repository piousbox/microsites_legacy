class UsersController < ApplicationController
  caches_page :resume, :show, :index, :reports, :report, :galleries, :gallery, :github_page
  layout 'resume'

  def gallery
    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    authorize! :show, @gallery

    @user = @gallery.user
    set_galleries
    @title = "Gallery #{@gallery.name} of #{@user.username}"
  end

  def edit
    @user = User.find current_user.id
    authorize! :edit, @user
  end

  def show
    if Rails.env.production? && 'piousbox.com' != @domain
      authorize! :not_found, User.new
      redirect_to "http://piousbox.com#{request.path}"

    elsif Rails.env.development? && 'pi.local' != @domain
      authorize! :not_found, User.new
      redirect_to "http://pi.local:3010#{request.path}"

    else
      @user = User.where( :username => params[:username] ).first
      authorize! :show, @user
      if @user.blank?
        render :not_found
      else

        @profile = UserProfile.where( :user => @user, :lang => @locale ).first
        @title = @user.username

        if params[:print]
          render :print, :layout => 'print'
        else
          render
        end
      end
    end
  end
  
  def galleries
    @user = User.where( :username => params[:username] ).first
    authorize! :galleries, @user
    set_galleries
    @title = "Galleries of #{@user.username}"
  end

  def scratchpad
    s = params[:user][:scratchpad]
    @current_user.scratchpad = s
    authorize! :scratchpad, @current_user
    
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
    authorize! :show, @report    
  end

  def github_page
    @user = User.where( :username => params[:username] ).first
    authorize! :github, @user
    render :action => :github
  end
 
  def reports
    @user = User.where( :username => params[:username] ).first
    authorize! :reports, @user

    @reports = Report.where( :lang => @locale, :user => @user, :is_public => true, :is_trash => false ).order_by( :created_at => :desc ).page( params[:reports_page] )

    respond_to do |format|
      format.html
      format.json do
        render :json => @reports
      end
    end
  end
  
  def index
    authorize! :index, User.new
    @title = 'All Users'
    @users = User.all
    
    unless params[:cityname].blank?
      @city = City.where( :cityname => params[:cityname] ).first
      @users = @users.where( :current_city => @city )
    end

    if !params[:q].blank?
      @users = @users.where( :username => /#{params[:q]}/i )
    else
      @users = @users.select do |user|
        user.reports.length > 0 || user.galleries.length > 0
      end
    end
    n = User.per_page # n = 16
    p = params[:users_page] || 1 # page
    b = (p-1)*n # begin
    e = p*n # end
    @users = @users[b...e]

    respond_to do |format|
      format.html do
        if params[:cityname]
          @features = []
          render :layout => 'application_cities', :action => :list
        else
          render :layout => 'resume' # @layout
        end
      end
      format.json do
        render :json => @users
      end
    end
  end
  
  def organizer
    authorize! :organizer, @current_user

    # @reports = Report.where( :user => (current_user || session['current_user']) ).page(1)
    @newsitems = current_user.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] )

    @profiles = @current_user.user_profiles
    
    render :layout => @layout
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
      render :action => :edit, :layout => 'organizer'
    end   
  end

  def new_profile
    authorize! :new_profile, @current_user
    @user_profile = UserProfile.new
    render :layout => @layout
    
  end

  def create_profile
    authorize! :create_profile, @current_user

    @user_profile = UserProfile.new params[:user_profile]
    @user_profile.user = @current_user

    if @user_profile.save
      flash[:notice] = 'Success'
      redirect_to organizer_path
    else
      flash[:error] = 'No Luck'
      render :new_profile, :layout => @layout
    end
  end

  def about
    authorize! :about, User.new
    @title = 'About Us'
    render
  end

  private

  def set_galleries
    @galleries = Gallery.where( :user => @user, :is_trash => false, :is_public => true ).order_by( :created_at => :desc )
    @galleries = @galleries.select do |g|
      g.photos.where( :is_trash => false, :is_public => true ).length > 0
    end
  end

end
