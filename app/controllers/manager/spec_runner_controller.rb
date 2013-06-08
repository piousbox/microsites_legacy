
class Manager::SpecRunnerController < Manager::ManagerController

  layout false

  def cities
  end

  def all
  end

  def which
    render :cities # params[:which]
  end

end
