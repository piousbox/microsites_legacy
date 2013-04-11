
class My::ReportsController < My::MyController

  def index
    @reports = Report.where( :user => @current_user ).all
    authorize! :my_index, Report.new
    render :layout => @layout
  end

end
