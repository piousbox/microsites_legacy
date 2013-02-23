
class Manager::WelcomeController < Manager::ManagerController
  
  def homepage
    @nodes = [
      { :connect_string => 'ssh -i rails-quick-start.pem -p 2289 ubuntu@infiniteshelter.com', :node_name => 'app_server_7' }
    ]

    @apps = [
      { :id => 'showv-cakephp' },
      { :id => 'microsites2' },
      { :id => 'travel-guide' },
      { :id => 'piousbox-resume' },
      { :id => 'sample-python-app' },
      { :id => 'sample-java-app' }
    ]
  end
  
end