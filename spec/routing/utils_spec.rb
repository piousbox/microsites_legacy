require 'spec_helper'
describe Utils::SitemapsController do

  describe 'routes' do
    it 'sitemaps' do
      expect( :get => 'en/sitemap.xml' ).to route_to( 'utils/sitemaps#sitemap', :locale => 'en', :format => 'xml' )
      expect( :get => 'ru/sitemap.xml' ).to route_to( 'utils/sitemaps#sitemap', :locale => 'ru', :format => 'xml' )
      expect( :get => 'pt/sitemap.xml' ).to route_to( 'utils/sitemaps#sitemap', :locale => 'pt', :format => 'xml' )

      expect( :get => 'sitemap_photos.xml' ).to route_to( 'utils/sitemaps#photos', :format => 'xml' )
    end
  end

end
