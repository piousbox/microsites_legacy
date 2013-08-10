require 'spec_helper'
describe WelcomeController do
  before :each do
    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    # @request.host = 'piousbox.com'
    # @request.env['HTTP_REFERER'] = 'test.host/about'

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
      expect( :get => 'en/features' ).to route_to( :controller => 'sites', :action => 'features', :locale => 'en' )
      expect( :get => 'en/newsitems' ).to route_to( :controller => 'sites', :action => 'newsitems', :locale => 'en' )
      expect( :get => 'en/features/page/2' ).to route_to( :controller => 'sites', :action => 'features', :locale => 'en', :features_page => '2' )
      expect( :get => 'en/newsitems/page/2' ).to route_to( :controller => 'sites', :action => 'newsitems', :locale => 'en', :newsitems_page => '2' )

      expect( :get => 'en/galleries' ).to route_to( :controller => 'galleries', :action => 'index', :locale => 'en' )
      expect( :get => 'en/galleries/page/2' ).to route_to( :controller => 'galleries', :action => 'index', :locale => 'en', :galleries_page => '2' )
      expect( :get => "en/galleries/show/#{@gallery.galleryname}" ).to route_to(
        :controller => 'galleries', :action => 'show', :locale => 'en', :galleryname => @gallery.galleryname )
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
      expect( :post => 'en/reports/5' ).to route_to( :controller => 'reports', :action => 'update', :locale => 'en', :id => '5' )

      expect( :get => 'en/users' ).to route_to( :controller => 'users', :action => 'index', :locale => 'en' )
      expect( :get => 'en/users/show/piousbox' ).to route_to( :controller => 'users', :action => 'show', :locale => 'en' )
      expect( :get => 'en/en/users/show/piousbox' ).to route_to( :controller => 'users', :action => 'show', :locale => 'en' )
      expect( :get => 'en/users/new' ).to route_to( :controller => 'users', :action => 'new', :locale => 'en' )
      expect( :get => 'en/user_profiles/new' ).to route_to( :controller => 'user_profiles', :action => 'new', :locale => 'en' )
      expect( :get => 'en/user_profiles/edit/5' ).to route_to( :controller => 'user_profiles', :action => 'edit', :locale => 'en', :id => '5' )
      expect( :post => 'en/user_profiles/5' ).to route_to( :controller => 'user_profiles', :action => 'update', :locale => 'en', :id => '5' )

      expect( :get => 'en/photos/new' ).to route_to( :controller => 'photos', :action => 'new', :locale => 'en' )
      expect( :post => 'en/photos' ).to route_to( :controller => 'photos', :action => 'create', :locale => 'en' )

      expect( :get => 'en/manager/edit-settings' ).to route_to( :controller => 'manager', :action => 'edit_settings', :locale => 'en' )
      expect( :post => 'en/manager/edit-settings' ).to route_to( :controller => 'manager', :action => 'update_settings', :locale => 'en' )
      expect( :post => 'en/manager/features' ).to route_to( :controller => 'manager', :action => 'features_create', :locale => 'en' )
      expect( :post => 'en/manager/clear-cache' ).to route_to( :controller => 'manager', :action => 'clear_cache', :locale => 'en' )
    end
  end

end
