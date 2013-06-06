
class Manager::WelcomeController < Manager::ManagerController

  before_filter :setup_defaults, :only => [ :homepage ]

  def homepage
    message_file = Rails.root.join('config', 'data', 'latest_commit_message')
    @latest_commit_message = File.read(message_file) unless !File.exists?(message_file)
  end

  def enqueue
    Resque.enqueue( TitleizeReports )
    flash[:notice] = 'Enqueued'
    redirect_to manager_root_path
  end

end
