
require 'spec_helper'
describe Manager::WelcomeController do
  render_views
  before :each do
    User.clear
    @manager = FactoryGirl.create :manager
    
    sign_in :user, @manager
  end

  describe 'router' do
    it 'routes to home' do
      expect(:get => '/en/manager' ).to route_to( :controller => 'manager/welcome', :action => 'homepage', :locale => 'en' )
    end
  end

  describe 'templates' do
    it 'renders home template' do
      get(:homepage, :locale => :en).should render_template('homepage')
    end
  end

  describe 'class variables' do
    it 'passes nodes to home' do
      get( :homepage, :locale => :en )
      assigns(:nodes).should_not eql nil
      assigns(:nodes).each do |node|
        node['node_name'].should_not eql nil
      end
    end
  end

  describe "homepage" do
    it 'should have scratchpad of logged in user' do
      get :homepage, :locale => :en
      response.should be_success
      response.should render_template('homepage')
      assigns(:current_user).should_not eql nil
      assert_select('.scratchpad')
    end

    it 'has latest commit message' do
      msg_path = Rails.root.join('config', 'data', 'latest_config_message')
      File.open(msg_path, 'w') { |file| file.write( "latest message for test" ) }
      get :homepage
      assigns(:latest_commit_message).should_not eql nil
      File.delete(msg_path)
    end

  end

  

end
