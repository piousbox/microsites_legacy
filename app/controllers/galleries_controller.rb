

class GalleriesController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    @galleries = Gallery.all.fresh.public.page( params[:galleries_page] )
  end
  
  def show  
    @gallery = Gallery.find(params[:id])
    
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
    @gallery[:name_seo] = @gallery[:name]

    begin
      @gallery.save
      redirect_to :controller => 'photos', :action => 'driver', :gallery_id => @gallery.id
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
