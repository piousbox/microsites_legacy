
class Manager::ReportsController < ManagerController

  def index
    @cities = City.list
    
    @reports = Report.all
    
    if '1' == params[:fresh]
      @reports = @reports.fresh
    end
    
    if '1' == params[:public]
      @reports = @reports.public
    end
    
  end
  
  def new
    @report = Report.new
  end
  
  def edit
    @report = Report.find( params[:id] )
  end
  
  def show
    @report = Report.find params[:id]
  end
  
  def search
    city = City.find params[:report][:city_id]
    @reports = Report.where( :city => city )
    render 'index'
  end
    
end
