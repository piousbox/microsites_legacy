require 'spec_helper'
describe Utils::SitemapsController do
  render_views

  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    Gallery.all.each { |g| g.remove }

    @user = User.all[0]

    @city = FactoryGirl.create :rio

    @g = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2

  end

  describe 'travel sitemap' do
    it 'has cities' do
      init_sitemap

      n_cities = City.all.length
      n_cities.should be >= 1
      assigns(:cities).should_not eql nil
      assigns(:cities).length.should eql n_cities
    end

    it 'all links to reports should have domain travel-guide.mobi in the link address' do
      init_sitemap
      result = Nokogiri::XML(@request.body)
      puts! result
    end

    it 'only has galleries of travel-guide.mobi' do
      init_sitemap
      galleries = assigns(:galleries)
    end

    it 'has venues' do
      init_sitemap
      venues = assigns(:venues)
    end

  end

  private

  def init_sitemap
      @request.host = 'travel-guide.mobi'
      get :sitemap, :domainname => 'travel-guide.mobi', :locale => :en, :format => :xml
      response.should be_success
  end

end
