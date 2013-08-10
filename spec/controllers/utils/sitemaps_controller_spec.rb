require 'spec_helper'
describe Utils::SitemapsController do
  render_views
  before :each do

    Report.all.each { |c| c.remove }

    @user = User.all[0]

    Gallery.all.each { |g| g.remove }
    @g = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2

    setup_sites
    @travel_guide_mobi_en_site = Site.create :domain => 'travel-guide.mobi', :lang => :en
    @travel_guide_mobi_pt_site = Site.create :domain => 'travel-guide.mobi', :lang => :pt
  end

  describe 'travel sitemap' do
    it 'all links to reports should have domain travel-guide.mobi in the link address' do
      init_sitemap
      result = Hash.from_xml(@response.body)

      result['urlset']['url'].each do |url|
        url['loc'].include?('travel-guide.mobi').should eql true
        url['loc'].include?('/en/').should eql true
      end
      result['urlset']['url'].length.should be >= 2
    end

    it 'has the entry for cities index' do
      init_sitemap
      result = Hash.from_xml(@response.body)
      locs = result['urlset']['url'].map do |url|
        url['loc']
      end
      locs.include?('http://travel-guide.mobi/en/cities').should eql true
    end

    it 'only has galleries of travel-guide.mobi' do
      init_sitemap
      assigns(:site).should_not eql nil

      galleries = assigns(:galleries)
      galleries.should_not eql nil
      galleries.each do |g|
        g.site.domain.should eql 'travel-guide.mobi'
      end
    end

  end

  describe 'default sitemap' do
    it 'shows something' do
      @request.host = 'nonesiting.local'
      get :sitemap, :domainname => 'nonexistent', :locale => :en, :format => :xml
      response.should be_success
    end
  end

  private

  def init_sitemap
      @request.host = 'travel-guide.mobi'
      get :sitemap, :domainname => 'travel-guide.mobi', :locale => :en, :format => :xml
      response.should be_success
  end

end
