
class Manager::WelcomeController < Manager::ManagerController

  before_filter :setup_defaults, :only => [ :homepage ]

  def homepage
    authorize! :homepage, Manager.new

    message_file = Rails.root.join('config', 'data', 'latest_commit_message')
    @latest_commit_message = File.read(message_file) unless !File.exists?(message_file)
  end

  def enqueue
    authorize! :enqueue, Manager.new

    Resque.enqueue( TitleizeReports )
    Resque.enqueue( ReportsRemoveTrash )
    flash[:notice] = 'Enqueued'
    redirect_to manager_root_path
  end

  def js_experimental
    authorize! :js_experimental, Manager.new
  end

end
