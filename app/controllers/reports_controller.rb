
class ReportsController < ApplicationController
  
  #  caches_page :index
  #  caches_page :homepage
  #  caches_page :show
  #  cache_sweeper :report_sweeper

  before_filter :load_features, :only => [ :show ]

  def new
    @report = Report.new
    authorize! :new, @report
    @cities = City.list

    respond_to do |format|
      format.html do
        render :layout => 'organizer'
      end
      format.json { render :json => @report }
    end
  end

  def create
    @report = Report.new params[:report]
    @report.user = @current_user || User.where( :username => 'anon' ).first
    @report.username = @report.user.username
    @report[:lang] = @locale
    @report.name_seo ||= @report.name.to_simple_string
    authorize! :create, @report

    verified = true
    saved = false
    if @current_user.blank?
      verified = verify_recaptcha( :model => @report, :message => 'There is a problem with recaptcha.' )
    end

    if verified
      
      if @report.is_public && !@report.city.blank?

        n = Newsitem.new
        n.report = @report
        n.descr = 'shared a story on'
        n.user = current_user
        @report.city.newsitems << n
        if @report.city.save
          flash[:notice] = 'newsitem saved'
        else
          flash[:error] = 'City could not be saved (newsitem).'
        end
      else
        flash[:notice] = 'Newsitem was not attempted to be saved.'
      end

      saved = @report.save
    end

    respond_to do |format|
      if saved
        format.html { redirect_to report_path(@report.name_seo), :notice => 'Report was successfully created (but newsitem, no information.' }
        format.json { render :json => @report, :status => :created, :location => @report }
      else
        format.html do
          # puts! @report.errors
          flash[:error] = @report.errors.inspect
          render :action => "new"
        end
        format.json { render :json => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @report = Report.find(params[:id],
      :include => [:tags]
    )
    authorize! :edit, @report
    @cities = City.list
    @tags = Tag.list

    respond_to do |f|
      f.html
      f.json
    end
  end
  
  def update
    @report = Report.find(params[:id])
    authorize! :update, @report

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
    authorize! :search, Report.new
    @reports = Report.where( :name => /#{params[:keyword]}/i )

    if params[:my]
      @reports = @reports.where( :user => current_user)
    end

    @reports = @reports.page( params[:reports_page] )
    
    render :action => :index
  end
  
  def index
    authorize! :index, Report.new
    
    @reports = Report.all.where( :lang => @locale, :tag => nil )

    if params[:cityname]
      city = City.where( :cityname => params[:cityname] ).first
      @reports = @reports.where( :city => city )
    end

    @reports = @reports.page( params[:reports_page] )
    
    respond_to do |format|
      format.html do
        if 'mobile' == @application
          render :layout => 'organizer'
        else
          render
        end
      end
      format.json do
        @r = []
        @reports.each do |r|
          unless r.photo.blank?
            r[:photo_url] = r.photo.photo.url(:thumb)
          end
          r.username ||= r.user.username
          r.username ||= ''
          r[:photo_url] ||= ''
          @r.push r
        end
        render :json => @r
      end
    end
  end

  def not_found
    authorize! :not_found, Report.new
  end
  
  def show
    unless params[:name_seo].blank?
      @report = Report.where( :name_seo => params[:name_seo] ).first
    else
      @report = Report.find params[:id]
    end
    
    if @report.blank?
      render :not_found
      authorize! :not_found, Report.new

    else
      authorize! :show, @report
      respond_to do |format|
        format.html do
          if @report.tag && @report.user.username == @report.tag.name_seo
            # if a characteristic tag
            redirect_to user_report_path(@report.name_seo)
          else
            if @report.tag.blank?
              @recommended = Report.all.where( :is_feature => true ).limit( Feature.n_features )
            else
              @recommended = Report.all.where( :tag => @report.tag ).limit( Feature.n_features )
              @recommended = @recommended.reject { |r| r.name_seo == @report.name_seo }
            end
            @city = @report.city
            @report_name_seo ||= @report.name_seo
            render :layout => @layout
          end
        end
      
        format.json do
          if @report.photo
            @report[:photo_url] = @report.photo.photo.url(:small)
          else
            @report[:photo_url] = '/assets/missing.png'
          end
          @report.username = @report.user.username
          @report.username ||= ''
          render :json => @report
        end
      end
    end
  end
  
end
