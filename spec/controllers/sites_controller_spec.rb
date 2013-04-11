require 'spec_helper'
describe SitesController do
  render_views
  before :each do
    City.all.each { |u| u.remove }
    @city = City.create :name => 'San Francisco', :cityname => 'San_Francisco'

    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1

    @request.host = 'piousbox.com'
    setup_sites
    @site = Site.where( :domain => 'piousbox.com', :lang => 'en' ).first

    Tag.all.each { |t| t.remove }
    @tag = FactoryGirl.create :tag_old
    @tag2 = FactoryGirl.create :tag2
  end

  describe 'features' do
    it 'GETs features' do
      get :features
      response.should render_template( 'sites/features' )
      assigns(:features).should_not eql nil
      features = assigns(:features)
      features.each_with_index do |f, idx|
        unless features.length == idx+1
          f.weight.should >= features[idx+1].weight
          if f.weight != features[idx+1].weight
            f.created_at.should >= features[idx+1].created_at
          end
        end
      end
    end

    it 'displays all features' do
      n_features = Feature.all.length
      get :show, :domainname => 'piousbox.com'
      assigns(:features).length.should eql n_features
    end
  end

  describe 'show' do
    it 'GETs show' do
      get :show, :domainname => 'piousbox.com'
      response.should render_template('sites/show')
    end

    it 'shows features, newsitems, no-parent tags' do
      get :show, :domainname => 'piousbox.com'
      assigns(:features).should_not eql nil
      assigns(:newsitems).should_not eql nil
      assigns(:newsitems).length.should be <= assigns(:site).n_newsitems
      assigns(:feature_tags).should_not eql nil
    end

    it 'shows up' do
      get :show, :domainname => 'piousbox.com'
      response.should be_success
      assigns(:features).should_not eql nil
      assigns(:newsitems).should_not eql nil
    end

    it 'sets display_ads toggle' do
      get :show, :domainname => 'piousbox.com'
      assigns(:display_ads).should_not eql nil
    end

    it 'sets locale' do
      get :show, :domainname => 'piousbox.com'
      assigns(:locale).should_not be nil
    end

    it 'can show a video newsitem' do
      n = Newsitem.new
      Video.all.first.should_not eql nil
      n.video = Video.all.first
      n.user = User.all.first
      n.descr = 'blah blah'
      @site.newsitems << n
      @site.lang = 'en'
      @site.save
      get :show, :domainname => @site.domain, :locale => 'en'

      # puts! Site.find(@site.id).newsitems.to_a
      # puts! assigns(:newsitems).to_a
      flag = false
      assigns(:newsitems).each do |n|
        if !n.video.blank?
          flag = true
        end
      end
      flag.should eql true
      
      assert_select(".Nvideo")
    end

    it 'shows feature cities' do
      get :show, :domainname => 'piousbox.com'      
      cities = assigns(:feature_cities)
      cities.should_not eql nil
      cities.to_a.length.should <= City.n_features
    end

    it 'lists tags for the header' do
      get :show, :domainname => 'piousbox.com'
      assigns(:parent_tags).length.should > 0
    end

  end

end
