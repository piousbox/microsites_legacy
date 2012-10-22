

class GalleriesController < ApplicationController
  
  load_and_authorize_resource
  
  def free_photo_hosting
    render :layout => false
  end
  
  def index
    @galleries = Gallery.all.fresh.public.page( params[:galleries_page] )
    
  end
  
  def show  
    if params[:name_seo].blank?
      @gallery = Gallery.find(params[:id])
      unless @gallery[:name_seo].blank?
        redirect_to :action => :show, :name_seo => @gallery[:name_seo],
          :photo_id => 0, :id => nil,
          :status => :moved_permanently
      else
        raise Error404
      end
    else
      @gallery = Gallery.find_by_name_seo(params[:name_seo],
        :include => [ :city, :tags ]
      )
      if @gallery.blank?
        flash[:notice] = t('galleries.error_404', :name => params[:name_seo])
        redirect_to :action => :search, :keywords => params[:name_seo]
      else
    
        @gallery[:user] = User.find(:first,
          :conditions => { :id => @gallery[:user_id] },
          :include => [ :reports, :galleries ]
        )
    
    
        @photos = Photo.find(:all,
          :conditions => { :gallery_id => @gallery[:id], :is_trash => 0 }
        )
        
        if params[:set_style] == 'wide'
          render :action => :show_wide, :layout => 'container'
        else
          render :layout => 'roxie'
        end
      end
    end
  end

  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html 
      format.json { render :json => @gallery }
    end
  end

  

  def create
    
    @gallery = Gallery.new(params[:gallery])
    
    @gallery[:user_id] = current_user[:id]
    @gallery[:name_seo] = @gallery[:name].to_slug

    begin
      @gallery.save!
      redirect_to :controller => 'photos', :action => 'driver', :gallery_id => @gallery[:id]
      # render 'photos/driver'
    rescue ActiveRecord::RecordInvalid 
      flash[:error] = @gallery.errors
      respond_to do |format|
        format.html { render :action => "new" }
        format.json { render :json => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  def search
    @galleries = Gallery.paginate :page => params[:galleries_page],
      :conditions => { :is_public => 1, :is_trash => 0 }
    
    render :action => :index
  end
  
end
