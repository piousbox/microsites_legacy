
class Manager::NodesController < Manager::ManagerController

  def run_client

    node = @nodes.select { |n| n[:node_name] == params[:node_name] }[0]

    host = 'infiniteshelter.com'
    user = 'ubuntu'
    keys = [ '/Users/victor.pudeyev/projects/rails-quick-start/rails-quick-start.pem' ]

    @result = ''
    @result = @result + `cd ~/projects/microsites2 && be rspec spec`
    @result = @result + `cd ~/projects/microsites2 && be rake test`
    @result = @result + `cd ~/projects/microsites2 && be rake assets:precompile && git add . && git commit -am "automated commit" && git push origin master`
    @result = @result + `cd ~/projects/microsites2 && rm -rf public/assets`
    
    Net::SSH.start( host, user, :port => node[:port], :keys => keys ) do|ssh|
      @result = @result + ssh.exec!('sudo chef-client')
      @result = @result + ssh.exec!('sudo service microsites2-app restart')
    end
    
  end

end
