
class Manager::WelcomeController < Manager::ManagerController

  before_filter :setup_defaults, :only => [ :homepage ]

  def homepage
    ;
  end

end
