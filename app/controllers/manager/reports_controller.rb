
class Manager::ReportsController < Manager::ManagerController
  
  def index
    @cities = City.list
    @tags = Tag.list
    @reports = Report
    
    if params[:search_words] && '' != params[:search_words]
      @reports = @reports.where( :name => /#{params[:search_words]}/i )
    end

    if @this_domain = params[:this_domain]
      @this_tag = Tag.where( :domain => @this_domain ).first
      if @this_tag.nil?
        flash[:notice] = "No reports in #{@this_domain}."
      else
        @reports = @reports.where( :tag => @this_tag )
      end
    end

    if params[:is_features]
      @reports = @reports.where( :is_feature => true )
      @is_features = true
    end

    if params[:is_untagged]
      @reports = @reports.where( :tag => nil )
      @is_untagged = true
    end

    if params[:is_done]
      @reports = @reports.where( :is_done => true )
      @is_dones = true
    elsif params[:is_undone]
      @reports = @reports.where( :is_done => false )
      @is_undones = true
    end
    
    @reports = @reports.page( params[:reports_page] )
  end

  def mark_features
    ;
  end
  
  def new
    @report = Report.new
    
    sett_lists

    if !params[:venuename].blank?
      @venue = Venue.where( :name_seo => params[:venuename] ).first
      # render :layout => 'organizer'
    end
    
  end
  
  def create
    sett_lists
    
    @report = Report.new params[:report]
    @report.user = @current_user
    @report.name_seo = @report.name.to_simple_string
    
    unless @report.venue_id.blank?
      @venue = Venue.find @report.venue_id
    end

    if @report.save
      flash[:notice] = 'Success'
      redirect_to manager_reports_path
    else
      puts! @report.errors
      flash[:error] = @report.errors.inspect
      render :action => :new
    end
  end
  
  
  def edit
    sett_lists

    @report = Report.find( params[:id] )
  end
  
  def update
    sett_lists
    
    @r = Report.find params[:id]
    @r.user = User.where( :username => 'piousbox' ).first if @r.user.blank?

    if params[:report][:photo]
      p = Photo.new
      p.photo = params[:report][:photo]
      p.save
      @r.photo = p
      params[:report][:photo] = nil
    end

    @r.update_attributes params[:report]
    
    if @r.save
      flash[:notice] = 'Success'
    else
      flash[:error] = "No Luck: #{@r.errors.inspect}"
    end
    redirect_to manager_reports_path
  end
  
  def show
    @report = Report.find params[:id]
  end
  
  def destroy
    @g = Report.find params[:id]
    @g.is_trash = 1
    
    if @g.save
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
    end
    
    redirect_to manager_reports_path
  end

  private

  def sett_lists
    @cities = City.list
    @tags = Tag.list
    @list_venues = Venue.list
  end
    
end
