
require 'test_helper'

class Utils::SitemapsControllerTest < ActionController::TestCase

  setup do
    @request.host = 'piousbox.com'

    Report.clear

    User.clear
    @user = FactoryGirl.create :user
    @manager = FactoryGirl.create :manager

    @tag_cac = FactoryGirl.create :tag_cac
    @cac_1 = FactoryGirl.create :cac1
    Tag.clear
    Tag.create :name => 'WDZ', :name_seo => 'wdz', :domain => 'blog.wevdevzine.com'
    FactoryGirl.create :tag_sedux
    FactoryGirl.create :tag_travel
    FactoryGirl.create :tag_qxt

    setup_sites
  end
 
  test 'pi sitemap' do
    @request.host = 'piousbox.com'
    get :sitemap, :format => :xml
    assert_response :success
  end

  test 'ish' do
    @request.host = 'infiniteshelter.com'
    get :sitemap, :format => :xml
    assert_response :success
  end

  test 'qxt' do
    @request.host = 'organizer.annesque.com'
    get :sitemap, :format => :xml
    assert_response :success
  end

  test 'cac' do
    @request.host = 'computationalartscorp.com'
    get :sitemap, :format => :xml
    assert_response :success
  end

  test 'travel' do
    @request.host = 'travel-guide.mobi'
    get :sitemap, :format => :xml
    assert_response :success
  end

end
