

class UsersController < ApplicationController
  
  load_and_authorize_resource
  skip_authorization_check :only => [ :sign_in, :sign_up ]
  
  # caches_page :resume
  # cache_sweeper :user_sweeper

  def gallery
    @gallery = Gallery.where( :galleryname => params[:galleryname] ).first
    @user = @gallery.user
    @title = "Gallery #{@gallery.name} of #{@user.username}"
    render :layout => 'resume'
  end

  def resume

    @user = User.where( :username => params[:username] ).first
    @profile = UserProfile.where( :user => @user, :lang => params[:locale] ).first
    @title = "resume #{@user.username}"

    if params[:print]
      render :print, :layout => 'print'
    else
      render :layout => 'resume'
    end
    
  end

  def show
    @user = User.where( :username => params[:username] ).first

    respond_to do |format|
      format.html
      format.json do
        @user[:photo_url] = ''
        render :json => @user
      end
    end
  end
  
  def galleries
    @user = User.where( :username => params[:username] ).first
    tag = Tag.where( :name_seo => @user.username ).first
    @galleries = Gallery.fresh.public.where( :tag => tag ).page( params[:galleries_page] )
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
      @reports = []
    else
      @reports = Report.fresh.public.where( :tag => @tag ).page( params[:reports_page] )
    end
    

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
    render 'settings', :layout => 'organizer'
  end
  
  def index
    @title = 'All Users'
    @users = User.fresh

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
    @addressbookitem = Addressbookitem.new
    @newsitems = @current_user.newsitems.all.order_by( :created_at => :descr ).limit( 6 )
    render :layout => 'organizer'
  end
  
  def photos
    @photos = Photo.where( :user => (current_user || session['current_user']) ).page( params[:photos_page] )
    render :layout => 'organizer'
  end
  
end