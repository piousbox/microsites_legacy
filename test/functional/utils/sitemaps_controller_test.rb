
require 'test_helper'

class Utils::SitemapsControllerTest < ActionController::TestCase

  setup do
    @request.host = 'cac.local'

    Report.clear

    Tag.clear

    User.clear
    @user = FactoryGirl.create :user
    @manager = FactoryGirl.create :manager

    @tag_cac = FactoryGirl.create :tag_cac
    @cac_1 = FactoryGirl.create :cac1

  end

  test 'sanity' do
    assert true
  end
  
end