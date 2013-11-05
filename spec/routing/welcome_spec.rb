require 'spec_helper'
describe WelcomeController do
  before :each do
    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site

    Gallery.all.each { |g| g.remove }
    @gallery = FactoryGirl.create :gallery

    Report.all.each { |r| r.remove }
    @report = FactoryGirl.create :report

  end

  describe 'routes' do
    it 'routes' do
      expect( :get => '/' ).to route_to( 'welcome#home' )
      expect( :get => 'en/sites/piousbox.com/features' ).to route_to( :controller => 'sites', :action => 'features', :locale => 'en',
                                                                           :domainname => 'piousbox.com' )
      expect( :get => 'en/sites/piousbox.com/features/page/2' ).to route_to( :controller => 'sites', :action => 'features', :locale => 'en', 
                                                                       :features_page => '2', :domainname => 'piousbox.com' )
      expect( :get => 'en/sites/piousbox.com/newsitems/page/2' ).to route_to( :controller => 'sites', :action => 'show', :locale => 'en',
                                                                        :newsitems_page => '2', :domainname => 'piousbox.com' )

      expect( :get => 'en/galleries' ).to route_to( :controller => 'galleries', :action => 'index', :locale => 'en' )
      expect( :get => 'en/galleries/page/2' ).to route_to( :controller => 'galleries', :action => 'index', :locale => 'en', :galleries_page => '2' )
      expect( :get => "en/galleries/show/some-gallery" ).to route_to(
        :controller => 'galleries', :action => 'show', :locale => 'en', :galleryname => 'some-gallery', :style => 'show' )
      expect( :get => "en/galleries/show/#{@gallery.galleryname}/2" ).to route_to( 
        :controller => 'galleries', :action => 'show', :locale => 'en', :galleryname => @gallery.galleryname, :photo_idx => '2' )
      expect( :get => "en/galleries/show_long/#{@gallery.galleryname}" ).to route_to(
        :controller => 'galleries', :action => 'show', :locale => 'en', :galleryname => @gallery.galleryname, :style => 'show_long' )
      expect( :get => "en/galleries/show_mini/#{@gallery.galleryname}" ).to route_to( 
        :controller => 'galleries', :action => 'show', :locale => 'en', :galleryname => @gallery.galleryname, :style => 'show_mini' )
      expect( :get => 'en/galleries/new' ).to route_to( :controller => 'galleries', :action => 'new', :locale => 'en' )
      expect( :post => 'en/galleries' ).to route_to( :controller => 'galleries', :action => 'create', :locale => 'en' )
      expect( :get => 'en/galleries/5/edit' ).to route_to( 'galleries#edit', :id => '5', :locale => 'en' )
      expect( :post => 'en/galleries/5' ).to route_to( :controller => 'galleries', :action => 'update', :locale => 'en', :id => '5' )

      expect( :get => 'en/reports' ).to route_to( :controller => 'reports', :action => 'index', :locale => 'en' )
      expect( :get => 'en/reports/page/2' ).to route_to( :controller => 'reports', :action => 'index', :locale => 'en', :reports_page => '2' )
      expect( :get => "en/reports/show/#{@report.name_seo}" ).to route_to( :controller => 'reports', :action => 'show', :locale => 'en', :name_seo => @report.name_seo )
      expect( :get => 'en/reports/new' ).to route_to( :controller => 'reports', :action => 'new', :locale => 'en' )
      expect( :post => 'en/reports' ).to route_to( :controller => 'reports', :action => 'create', :locale => 'en' )
      expect( :get => 'en/reports/5/edit' ).to route_to( :controller => 'reports', :action => 'edit', :locale => 'en', :id => '5' )
      expect( :put => 'en/reports/5' ).to route_to( :controller => 'reports', :action => 'update', :locale => 'en', :id => '5' )

      expect( :get => 'en/users' ).to route_to( :controller => 'users', :action => 'index', :locale => 'en' )
      expect( :get => 'en/users/show/piousbox' ).to route_to( :controller => 'users', :action => 'show', :locale => 'en', :username => 'piousbox' )
      # expect( :get => 'en/users/new' ).to route_to( :controller => 'users', :action => 'new', :locale => 'en' )
      expect( :get => 'en/users/new_profile' ).to route_to( :controller => 'users', :action => 'new_profile', :locale => 'en' )
      expect( :get => "en/users/#{@user.username}/profiles/5/edit" ).to route_to( :controller => 'users', :action => 'edit_profile',
        :locale => 'en', :username => @user.username, :profile_id => '5' )
      expect( :put => "en/users/#{@user.username}/profiles/5" ).to route_to( :controller => 'users', :action => 'update_profile',
        :locale => 'en', :profile_id => '5', :username => @user.username )

      expect( :get => 'en/photos/new' ).to route_to( :controller => 'photos', :action => 'new', :locale => 'en' )
      expect( :post => 'en/photos' ).to route_to( :controller => 'photos', :action => 'create', :locale => 'en' )

      expect( :get => 'en/users/organizer/' ).to route_to( 'users#organizer', default_routing_options )

      # expect( :get => 'en/manager/edit-settings' ).to route_to( :controller => 'manager', :action => 'edit_settings', :locale => 'en' )
      # expect( :post => 'en/manager/edit-settings' ).to route_to( :controller => 'manager', :action => 'update_settings', :locale => 'en' )
      # expect( :post => 'en/manager/features' ).to route_to( :controller => 'manager', :action => 'features_create', :locale => 'en' )
      # expect( :post => 'en/manager/clear-cache' ).to route_to( :controller => 'manager', :action => 'clear_cache', :locale => 'en' )

      expect( :get => 'en/videos' ).to route_to( 'videos#index', default_routing_options )
      expect( :get => 'en/videos/show/5' ).to route_to( 'videos#show', default_routing_options.merge( :youtube_id => '5' ) )
      expect( :get => 'en/videos/page/2' ).to route_to( 'videos#index', default_routing_options.merge( :videos_page => '2' ) )
    end
  end

  it 'search' do
    expect( :get => 'search?q=aaa' ).to route_to( 'welcome#search' )
  end

  it 'privacy & contact & other' do
    expect( :get => '/en/privacy' ).to route_to( 'welcome#privacy', default_routing_options )
    expect( :get => '/en/contact' ).to route_to( 'welcome#contact', default_routing_options )
  end

  def default_routing_options
    { :locale => 'en' }
  end

  def options
    default_routing_options
  end

end
