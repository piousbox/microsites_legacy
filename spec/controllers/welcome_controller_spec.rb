require 'spec_helper'
describe WelcomeController do
  render_views
  before :each do
    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    @request.host = 'piousbox.com'
    @request.env['HTTP_REFERER'] = 'test.host/about'

    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site
  end

  describe 'Welcome Guest' do
    it 'GETs homepage' do
      get :home
      response.should be_redirect
      response.should redirect_to( :controller => 'sites', :action => 'show' )
    end
  end

  describe 'routes' do
    it 'routes' do
      expect( :get => '/' ).to route_to( :controller => 'welcome', :action => 'home' )
      expect( :get => '/features' ).to route_to( :controller => 'sites', :action => 'features' )
      expect( :get => '/newsitems' ).to route_to( :controller => 'sites', :action => 'newsitems' )
      expect( :get => '/features/page/2' ).to route_to( :controller => 'sites', :action => 'features' )
      expect( :get => '/newsitems/page/2' ).to route_to( :controller => 'sites', :action => 'newsitems' )

      expect( :get => '/galleries' ).to route_to( :controller => 'galleries', :action => 'index' )
      expect( :get => '/galleries/page/2' ).to route_to( :controller => 'galleries', :action => 'index' )
      expect( :get => "/galleries/view/#{@gallery.galleryname}" ).to route_to( :controller => 'galleries', :action => 'show' )
      expect( :get => "/galleries/view/#{@gallery.galleryname}/2" ).to route_to( :controller => 'galleries', :action => 'show' )
      expect( :get => "/galleries/show_long/#{@gallery.galleryname}" ).to route_to( :controller => 'galleries', :action => 'show' )
      expect( :get => "/galleries/show_mini/#{@gallery.galleryname}" ).to route_to( :controller => 'galleries', :action => 'show' )
      expect( :get => '/galleries/new' ).to route_to( :controller => 'galleries', :action => 'new' )
      expect( :post => '/galleries' ).to route_to( :controller => 'galleries', :action => 'create' )
      expect( :get => '/galleries/5/edit' ).to route_to( :controller => 'galleries', :action => 'edit' )
      expect( :post => '/galleries/5' ).to route_to( :controller => 'galleries', :action => 'update' )

      expect( :get => '/reports' ).to route_to( :controller => 'reports', :action => 'index' )
      expect( :get => '/reports/page/2' ).to route_to( :controller => 'reports', :action => 'index' )
      expect( :get => "/reports/view/#{@report.name_seo}" ).to route_to( :controller => 'reports', :action => 'show' )
      expect( :get => '/reports/new' ).to route_to( :controller => 'reports', :action => 'new' )
      expect( :post => '/reports' ).to route_to( :controller => 'reports', :action => 'create' )
      expect( :get => '/reports/5/edit' ).to route_to( :controller => 'reports', :action => 'edit' )
      expect( :post => '/reports/5' ).to route_to( :controller => 'reports', :action => 'update' )

      expect( :get => '/users' ).to route_to( :controller => 'users', :action => 'index' )
      expect( :get => '/users/show/piousbox' ).to route_to( :controller => 'users', :action => 'show' )
      expect( :get => '/en/users/show/piousbox' ).to route_to( :controller => 'users', :action => 'show' )
      expect( :get => '/users/new' ).to route_to( :controller => 'users', :action => 'new' )
      expect( :get => '/user_profiles/new' ).to route_to( :controller => 'user_profiles', :action => 'new' )
      expect( :get => '/user_profiles/edit/5' ).to route_to( :controller => 'user_profiles', :action => 'edit' )
      expect( :post => '/user_profiles/5' ).to route_to( :controller => 'user_profiles', :action => 'update' )

      expect( :get => '/photos/new' ).to route_to( :controller => 'photos', :action => 'new' )
      expect( :post => '/photos' ).to route_to( :controller => 'photos', :action => 'create' )

      expect( :get => '/manager/edit-settings' ).to route_to( :controller => 'manager', :action => 'edit_settings' )
      expect( :post => '/manager/edit-settings' ).to route_to( :controller => 'manager', :action => 'update_settings' )
      expect( :post => '/manager/features' ).to route_to( :controller => 'manager', :action => 'features_create' )
      expect( :post => '/manager/clear-cache' ).to route_to( :controller => 'manager', :action => 'clear_cache' )
    end
  end

  describe 'user authentication' do
    it 'can login' do
      false.should eql true # @TODO
    end
  end

end
