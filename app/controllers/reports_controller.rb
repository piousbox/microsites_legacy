
class ReportsController < ApplicationController

  before_filter :load_features, :only => [ :show ]

  caches_page :index, self::CACHE_OPTIONS
  caches_page :not_found, self::CACHE_OPTIONS
  caches_page :show, self::CACHE_OPTIONS

  def new
    @report = Report.new
    authorize! :new, @report
    @tags_list = Tag.all.where( :is_public => true ).list
    @sites_list = Site.all.list

    respond_to do |format|
      format.html do
        render
      end
      format.json { render :json => @report }
    end
  end

  def create
    @report = Report.new params[:report]
    authorize! :create, @report

    @report.user = @current_user || User.where( :username => 'anon' ).first
    @report.username = @report.user.username
    @report[:lang] = @locale
    @report.name_seo ||= @report.name.to_simple_string
    @report.is_feature = false

    saved = false
    verified = verify_recaptcha( :model => @report, :message => 'There is a problem with recaptcha.' )

    if verified
      # for homepage
      if @report.is_public
        n = Newsitem.new
        n.report = @report
        n.descr = 'shared a story on'
        n.user = @report.user
        @site.newsitems << n
        if @site.save
          ;
        else
          flash[:error] = flash[:error] + 'City could not be saved (newsitem). '
        end
      end

      saved = @report.save
    end

    respond_to do |format|
      if saved
        expire_page :controller => 'reports', :action => 'index'
        expire_page :controller => 'sites', :action => 'show', :domainname => @site.domain
        format.html { redirect_to organizer_path, :notice => 'Report was successfully created (but newsitem, no information).' }
        format.json { render :json => @report, :status => :created, :location => @report }
      else
        format.html do
          # puts! @report.errors
          flash[:error] = @report.errors.inspect
          @tags_list = Tag.all.where( :is_public => true ).list
          @sites_list = Site.all.list

          render :action => "new"
        end
        format.json { render :json => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @report = Report.find(params[:id])
    authorize! :edit, @report

    @tags_list = Tag.all.where( :is_public => true ).list
    @sites_list = Site.all.list

    respond_to do |f|
      f.html
      f.json
    end
  end
  
  def update
    @report = Report.find(params[:id])
    authorize! :update, @report

    @tags_list = Tag.all.where( :is_public => true ).list
    @sites_list = Site.all.list

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html do
          redirect_to report_path(@report.name_seo), :notice => 'Report was successfully updated.'
        end
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
    if params[:domainname].blank?
      redirect_to sites_reports_path( @site.domain )
    else
      @reports = Report.all.where( :site => @site )
      @reports = @reports.page( params[:reports_page] )
      respond_to do |format|
        format.html do
          if params[:cityname]
            @features = []
            render :action => :list
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
              @recommended = Report.all.where( :tag => @report.tag, :lang => @locale ).limit( 7 )
              @recommended = @recommended.reject { |r| r.name_seo == @report.name_seo }
            end
            @report_name_seo ||= @report.name_seo
            render
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
