
class Manager::ReportsController < Manager::ManagerController
  
  def index
    @cities = City.list
    @tags = Tag.list
    @reports = Report.all.fresh
    
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
      @reports = @reports.features
      @is_features = true
    end
    
    @reports = @reports.page( params[:reports_page] )
  end

  def mark_features
    ;
  end
  
  def new
    @report = Report.new

  end
  
  def create
    @report = Report.new params[:report]
    @report.user = @current_user

    if @report.save
      flash[:notice] = 'Success'
      redirect_to manager_reports_path
    else
      flash[:error] = @report.errors.inspect
      render :action => :new
    end
  end
  
  
  def edit
    @cities = City.list
    @tags = Tag.list
    @report = Report.find( params[:id] )
  end
  
  def update
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
    
end
