
class Manager::ReportsController < ManagerController

  def index
    @cities = City.list
    
    @reports = Report.fresh
    
    if '1' == params[:public]
      @reports = @reports.public
    end
    
    if params[:report] && params[:report][:city_id] && params[:report][:city_id] != ''
      @city = City.find params[:report][:city_id]
      @reports = @reports.where( :city => @city )
    end
    
    @reports = @reports.page( params[:reports_page] ).per(20)
    
  end
  
  def new
    @report = Report.new
  end
  
  def edit
    @cities = City.list
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
