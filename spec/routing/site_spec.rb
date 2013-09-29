require 'spec_helper'
describe SitesController do

  describe 'Site routes' do
    it 'redirects simple reports' do
      expect( :get => '/en/reports' ).to route_to( :controller => 'reports', :action => 'index', :locale => 'en' )
    end

    it 'has routes for in-site reports' do
      expect( :get => '/en/sites/piousbox.com/reports' ).to route_to( :controller => 'reports', :action => 'index',
                                                                  :domainname => 'piousbox.com', :locale => 'en' )
    end

    it "has routes for in-site galleries" do
      expect( :get => '/en/sites/piousbox.com/galleries' ).to route_to( :controller => 'galleries', :action => 'index', 
                                                                    :domainname => 'piousbox.com', :locale => 'en' )
    end
                                                                                                 
  end

  private 

  def default_routing_options
    { :locale => 'en' }
  end

end
