

class ReportsController < ApplicationController
  
#  caches_page :index
#  caches_page :homepage
#  caches_page :show
#  cache_sweeper :report_sweeper
  
  def homepage
    @reports = Report.for_homepage :main_tag => @main_tag,
      :page => params[:page]
    
  end
  
  def new
    @report = Report.new
    @cities = City.list

    respond_to do |format|
      format.html
      format.json { render :json => @report }
    end
  end

  def edit
    @report = Report.find(params[:id],
      :include => [:tags]
    )
    @cities = City.list
    @tags = Tag.list
    
    respond_to do |f|
      f.html
      f.json
    end
  end

  def create
    @report = Report.new params[:report]
    @report[:lang] = @parsed_locale
    @report.user = current_user

    @report[:name_seo] = @report[:name].to_simple_string
    
    saved = false
    if @report.save
      saved = true
      
      if @report[:is_public] == 1
      
      
        @n = Newsitem.new
        @n[:city_id] = @report[:city_id]
        @n[:user_id] = @report[:user_id]
        @n[:date] = Time.now
        @n[:is_created] = 1
        @n[:some_id] = @report.id
        @n[:model_name] = 'Report'
        @n[:report_id] = @report.id
        @n.save!
      end
    end
    
    respond_to do |format|
      if saved
        format.html { redirect_to report_path(@report.name_seo), :notice => 'Report was successfully created (but newsitem, no information.' }
        format.json { render :json => @report, :status => :created, :location => @report }
      else
        format.html { render :action => "new" }
        format.json { render :json => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])

        format.html { redirect_to report_path(@report), :notice => 'Report was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @report.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def search
    
    @reports = Report.where( :name => /#{params[:search_keywords]}/ ).uniq
    render :action => :index
    
  end
  
  def index
    if params[:cityname].blank?
      @reports = Report.page( params[:reports_page] )
    else
      city = City.where( :cityname => params[:cityname] ).first
      @reports = Report.where( 'city' => city ).page( params[:reports_page] )
    end
    
    respond_to do |format|
      
      format.html do
        render :layout => false
      end
      
      format.json do
        @r = []
        @reports.each do |r|
          r[:photo_url] = r.photo.photo.url(:thumb)
          @r.push r
        end
        render :json => @r
      end
      
    end
  end
  
  def show
    
    unless params[:name_seo].blank?
      @report = Report.where( :name_seo => params[:name_seo] ).first
    else
      @report = Report.find params[:id]
    end

    puts! @report.photo
    
    respond_to do |format|
      format.html do
        render :layout => 'blog'
      end
      
      format.json do
        @report[:photo_url] = @report.photo.photo.url(:thumb)
        render :json => @report
      end
    end
    
  end
  
  private
  
end