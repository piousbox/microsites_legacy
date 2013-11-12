require 'spec_helper'
describe SitesController do
  render_views
  before :each do
    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1

    @request.host = 'piousbox.com'
    setup_sites
    @site = Site.where( :domain => 'piousbox.com', :lang => 'en' ).first || Site.first
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
    
    it 'GETs features page 2' do
      get :features, :features_page => 2, :domain => 'piousbox.com'
      response.should render_template( 'sites/features' )
    end
      
    it 'displays partial' do
      f = Feature.new( :partial_name => 'ads/small_square_blue', :weight => 20, :created_at => '2013-01-01' )
      @site.features << f 
      @site.save.should eql true
      get :show, :domainname => 'piousbox.com'
      assert_select('.ad-small-square-blue')
    end
  end

  describe 'show' do
    before :each do
      Photo.unscoped.each { |p| p.remove }
    end

    it 'GETs show, sets locale' do
      get :show, :domainname => 'piousbox.com'
      response.should be_success
      response.should render_template('sites/show')
      assigns(:locale).should_not be nil
      assigns(:features).should_not eql nil
      assigns(:newsitems).should_not eql nil
    end

    it 'GETs newsitems page 2' do
      get :show, :domainname => 'piousbox.com', :newsitems_page => 2
      response.should render_template( 'sites/show' )
    end

    it 'GETs json' do
      n = Newsitem.new :descr => 'Lalala'
      @site.newsitems << n
      @site.save
      @site.should_not eql nil

      get :show, :site_id => @site.id, :format => :json
      response.should be_success
      result = JSON.parse(response.body)
      result['features'].length.should eql 0
      result['newsitems'].length.should > 0
      result['newsitems'].each do |n|
        n['descr'].should_not eql nil
      end
    end

    it 'in newsitems, renders photos that are not inside a gallery' do
      @ph1 = FactoryGirl.create :photo
      @ph1.gallery.should eql nil
      n = Newsitem.new :photo => @ph1
      @site.newsitems << n
      @site.save
      @request.host = @site.domain
      get :show, :site_id => @site.id
      response.should be_success
    end
  end
  
  describe 'users/ link' do
    before :each do
      Site.all.each { |s| s.remove }
      @site = FactoryGirl.create :site
      @site.is_resume_enabled = true
      @site.domain = 'pi.local'
      @site.save
      
      request.host = 'pi.local'
    end
    
    it 'links properly if the site is user-enabled' do
      get :show, :domainname => 'pi.local'
      response.status.should be(200)
      assert_select '.users-link'
    end
    
    it 'links to piousbox.com if the site is not user-enabled' do
      @site.is_resume_enabled = false
      @site.save
      get :show, :domainname => @site.domain
      response.status.should be(200)
      assert_select '.users-link-external'
    end
    
  end

end
