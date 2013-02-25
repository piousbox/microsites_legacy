
class Manager::NodesController < Manager::ManagerController

  def run_client
    node_name = params[:node_name]
    # `cd ~/projects/rails-quick-start && ssh -i rails-quick-start.pem -p 2289 ubuntu@infiniteshelter.com`

    host = 'infiniteshelter.com'
    user = 'ubuntu'

    Net::SSH.start( host, user ) do|ssh|
      @result = ssh.exec!('sudo chef-client')
    end
  end

end