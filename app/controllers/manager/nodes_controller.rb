
class Manager::NodesController < Manager::ManagerController

  def run_client

    node = @nodes.select { |n| n[:node_name] == params[:node_name] }[0]

    host = 'infiniteshelter.com'
    user = 'ubuntu'
    keys = [ '/Users/victor.pudeyev/projects/rails-quick-start/rails-quick-start.pem' ]
    
    Net::SSH.start( host, user, :port => node[:port], :keys => keys ) do|ssh|
      @result = ssh.exec!('sudo chef-client')
      @result = @result + ssh.exec!('sudo service microsites2-app restart')
    end
    
  end

end
