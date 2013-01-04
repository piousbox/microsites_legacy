
require 'test_helper'

class RedirectToMobiTest < ActionDispatch::IntegrationTest

  fixtures :all

  test 'travel home' do
    host! 'piousbox.com'
    get '/travel'
    assert_response :redirect
    assert_redirected_to 'http://travel-guide.mobi/travel'

  end
end


