
require 'spec_helper'

describe WelcomeController do

  before :each do
    ;
  end

  describe 'routes' do
    it 'routes to home' do
      expect(:get => '/' ).to route_to( :controller => 'welcome', :action => 'home' )
    end
  end

  describe 'templates' do
    it 'renders home template' do
      get(:homepage).should render_template('homepage')
    end
  end

  describe 'class variables' do
    it 'passes nodes to home' do
      get(:homepage)
      assigns(:nodes).should_not eql nil
      assigns(:nodes).each do |node|
        node[:connect_string].should_not eql nil
        node[:node_name].should_not eql nil
      end
    end

    it 'passes apps list to home' do
      get :homepage
      assigns( :apps ).should_not eql nil
      assigns( :apps ).each do |app|
        app[:id].should_not eql nil
      end
    end
  end

end
