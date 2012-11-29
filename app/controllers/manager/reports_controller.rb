
class Manager::ReportsController < ManagerController
  
  def index
    @cities = City.list
    @reports = Report.fresh
    
    if params[:report]

      @reports = params[:report][:is_public] ? @reports.public : @reports.not_public
      @reports = params[:report][:is_done] ? @reports.done : @reports.not_done

      if params[:report]['search_words']
        @reports = @reports.where( :name => /#{params[:report]['search_words']}/ )
      end
      
      if params[:report][:city_id] && params[:report][:city_id] != ''
        @city = City.find params[:report][:city_id]
        @reports = @reports.where( :city => @city )
      else
        @reports = @reports.where( :city => nil )
      end
      
    end
    
    @reports = @reports.page( params[:reports_page] ).per(20)
  end
  
  def new
    @report = Report.new
  end
  
  def create
    @report = Report.new params[:report]
    @report.save
    redirect_to manager_reports_path
  end
  
  def edit
    @cities = City.list
    @tags = Tag.list
    @report = Report.find( params[:id] )
  end
  
  def update
    @r = Report.find params[:id]
    if @r.update_attributes params[:report]
      flash[:notice] = 'Success'
    else
      flash[:error] = 'No Luck'
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
