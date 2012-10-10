
class Manager::ReportsController < ManagerController

  def index
    @reports = Report.all
  end
  
  def new
    @report = Report.new
  end
  
  def edit
    @report = Report.find( params[:id] )
  end
    
end
