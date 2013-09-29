require 'spec_helper'
describe Utils::SitemapsController do

  describe 'routes' do
    it 'sitemaps' do
      expect( :get => '/en/sitemaps.xml' ).to route_to( 'utils/sitemaps#sitemap' )
      expect( :get => '/ru/sitemaps.xml' ).to route_to( 'utils/sitemaps#sitemap' )
      expect( :get => '/pt/sitemaps.xml' ).to route_to( 'utils/sitemaps#sitemap' )
    end
  end

end
