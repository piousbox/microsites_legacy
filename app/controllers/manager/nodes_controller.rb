
class Manager::NodesController < Manager::ManagerController

  before_filter :setup_defaults

  def push_commit
    authorize! :push_commit, Manager.new

    # @result = `cd ~/projects/microsites && be rake test && be rspec spec && git add . && git commit -am "automatic" && git push origin master`
  end
  
  def run_client
    authorize! :run_client, Manager.new

    node = @nodes.select { |n| n[:node_name] == params[:node_name] }[0]

    Net::SSH.start( node[:host], @user, :port => node[:port], :keys => @keys ) do|ssh|
      @result = ''
      @result = @result + ssh.exec!('sudo chef-client')
    end    
  end

  def restart_service
    authorize! :restart_service, Manager.new

  end

  def run_tests
    authorize! :run_tests, Manager.new

    # @result_1 = ''
    # @result_1 = @result_1 + `cd ~/projects/microsites2 && be rspec spec`
    # @result_1 = @result_1 + `cd ~/projects/microsites2 && be rake test`
    # @result_1 = @result_1 + `cd ~/projects/microsites2 && be rake assets:precompile && git add . && git commit -am "automated commit" && git push origin master`
    # @result_1 = @result_1 + `cd ~/projects/microsites2 && rm -rf public/assets`
  end
  
end
