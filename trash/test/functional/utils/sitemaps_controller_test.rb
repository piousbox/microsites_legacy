
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

end
