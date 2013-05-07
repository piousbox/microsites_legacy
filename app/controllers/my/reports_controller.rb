
class My::ReportsController < My::MyController

  def index
    @reports = Report.where( :user => @current_user ).all
    authorize! :my_index, Report.new
    render :layout => @layout
  end

  def create
    authorize! :create, Report.new
    redirect_to my_reports_path(:locale => @locale)
  end

end
