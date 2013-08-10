require 'spec_helper'
describe Utils::SitemapsController do
  render_views
  before :each do
    Report.all.each { |c| c.remove }

    User.clear
    @user = FactoryGirl.create :user

    Gallery.all.each { |g| g.remove }
    @g = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2

    setup_sites
    @request.host = 'piousbox.com'

  end

  describe 'travel sitemap' do
    it 'all links to reports should have domain travel-guide.mobi in the link address' do
      get :sitemap, :locale => :en, :format => :xml
      response.should be_success
      result = Hash.from_xml(@response.body)

      result['urlset']['url'].each do |url|
        url['loc'].include?('travel-guide.mobi').should eql true
        url['loc'].include?('/en/').should eql true
      end
      result['urlset']['url'].length.should be >= 2
    end

    it 'only has galleries of travel-guide.mobi' do
      get :sitemap, :locale => :en, :format => :xml
      response.should be_success
      assigns(:site).should_not eql nil

      galleries = assigns(:galleries)
      galleries.should_not eql nil
      galleries.each do |g|
        g.site.domain.should eql 'travel-guide.mobi'
      end
    end

  end

end
