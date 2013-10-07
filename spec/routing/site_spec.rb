require 'spec_helper'
describe SitesController do

  describe 'Site routes' do
    it 'redirects simple reports' do
      expect( :get => '/en/reports' ).to route_to( :controller => 'reports', :action => 'index', :locale => 'en' )
      expect( :get => '/en/galleries' ).to route_to( :controller => 'galleries', :action => 'index', :locale => 'en' )
    end

    it 'has routes for in-site reports' do
      expect( :get => '/en/sites/piousbox.com/reports' ).to route_to( :controller => 'reports', :action => 'index',
                                                                      :domainname => 'piousbox.com', :locale => 'en' )
      expect( :get => '/en/sites/piousbox.com/reports/page/5' ).to route_to( :controller => 'reports', :action => 'index',
                                                                      :domainname => 'piousbox.com', :locale => 'en', :reports_page => '5' )

    end

    it "has routes for in-site galleries" do
      expect( :get => '/en/sites/piousbox.com/galleries' ).to route_to( :controller => 'galleries', :action => 'index', 
                                                                    :domainname => 'piousbox.com', :locale => 'en' )
      expect( :get => '/en/sites/piousbox.com/galleries/page/2' ).to route_to( :controller => 'galleries', :action => 'index', 
                                                                    :domainname => 'piousbox.com', :locale => 'en', :galleries_page => '2' )
    end
                                                                                                 
  end

  private 

  def default_routing_options
    { :locale => 'en' }
  end

end
