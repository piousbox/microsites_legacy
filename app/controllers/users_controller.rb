
class UsersController < ApplicationController

  caches_page :resume, CACHE_OPTIONS
  caches_page :show, CACHE_OPTIONS
  caches_page :index, CACHE_OPTIONS
  caches_page :reports, CACHE_OPTIONS
  caches_page :report, CACHE_OPTIONS
  caches_page :galleries, CACHE_OPTIONS
  caches_page :gallery, CACHE_OPTIONS
  caches_page :github_page, CACHE_OPTIONS
  caches_page :about, CACHE_OPTIONS

  layout 'resume'

  before_filter :set_tags_global, :only => [ :gallery, :galleries, :show, :reports, :report, :index, :github_page, :about ]

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

  def report
    @report = Report.where( :name_seo => params[:name_seo] ).first

    if @report.blank?
      authorize! :not_found, Report.new
      @user = User.where( :username => 'anon' ).first
      render 'reports/not_found'

    else
      @user = @report.user
      authorize! :show, @report

    end
  end

  def github_page
    @user = User.where( :username => params[:username] ).first
    authorize! :github, @user
    render :action => :github
  end
 
  def reports
    @user = User.where( :username => params[:username] ).first
    authorize! :reports, @user

    @reports = Report.where( :user => @user, :site => @site ).page( params[:reports_page] ).per( 10 )

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
    
    if !params[:cityname].blank?
      @city = City.where( :cityname => params[:cityname] ).first
      @users = @users.where( :current_city => @city )
    end

    if !params[:q].blank?
      @users = @users.where( :username => /#{params[:q]}/i )
    else
      # @users = @users.select do |user|
      #   user.reports.length > 0 || user.galleries.length > 0
      # end
    end

    @users = @users.page( params[:users_page] ).per( 8 )

    # # @deprecated wtf is this?
    # n = User.per_page # n = 16
    # p = params[:users_page] || 1 # page
    # b = (p-1)*n # begin
    # e = p*n # end
    # @users = @users[b...e]

    respond_to do |format|
      format.html do
        render
      end
      format.json do
        render :json => @users
      end
    end
  end
  
  def organizer
    authorize! :organizer, current_user

    @cities_list = City.list
    @new_photo = Photo.new

    # @reports = Report.where( :user => (current_user || session['current_user']) ).page(1)
    @newsitems = current_user.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] )

    @profiles = current_user.user_profiles
    @my_reports = Report.where( :user => current_user, :site => @site ).order_by( :created_at => :desc ).page( params[:reports_page] )
    @my_galleries = Gallery.where( :user => current_user, :site => @site ).order_by( :created_at => :desc ).page( params[:galleries_page] )
    @my_videos = Video.where( :user => current_user, :site => @site ).order_by( :created_at => :desc ).page( params[:videos_page] )

    @title = t( 'users.settings_short' )
    render @layout => 'resume'
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
    authorize! :new_profile, current_user
    @user_profile = UserProfile.new
    @title = t('users.new_profile')
    render
  end

  def create_profile
    authorize! :create_profile, current_user

    @user_profile = UserProfile.new params[:user_profile]
    @user_profile.user = current_user

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

  def edit_profile
    authorize! :edit_profile, current_user
    @user_profile = current_user.user_profiles.where( :id => params[:profile_id] ).first
    @title = t('users.edit_profile')
    render
  end

  def update_profile
    authorize! :update_profile, current_user
    @user = User.find( current_user.id )
    @user_profile = @user.user_profiles.find( params[:profile_id] )
    if @user_profile.update_attributes params[:user_profile]
      flash[:notice] = 'Success'
      redirect_to organizer_path
    else
      flash[:error] = 'No Luck'
      @title = t('users.edit_profile')
      render :action => :edit_profile
    end
  end

  def new_message
    authorize! :new, Message.new
    UserMailer.welcome_email( current_user, @site ).deliver
    flash[:notice] = 'Success I think.'
    redirect_to organizer_path
  end

  #
  # private
  #
  private

  def set_galleries
    @galleries = Gallery.where( :user => @user, :site => @site ).per( 9 )
    @galleries = @galleries.select do |g|
      g.photos.length > 0
    end
  end

  def set_tags_global
    @tags_global = Tag.where( :is_trash => false, :is_public => true, :parent_tag => nil )
  end

end
