
require 'test_helper'

class Utils::SitemapsControllerTest < ActionController::TestCase

  setup do
    @request.host = 'cac.local'

    clear_reports
    clear_tags

    @tag_cac = FactoryGirl.create :tag_cac
    @cac_1 = FactoryGirl.create :cac1

  end

  test 'sanity' do
    assert true
  end
  
end