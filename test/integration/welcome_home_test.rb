
require 'test_helper'

class WelcomeHomeTest < ActionDispatch::IntegrationTest
  fixtures :all

  test 'redirect to piousbox.com from mobi and ish' do
    host! 'piousbox.com'
    
    get '/'
    assert_response :redirect
    assert_redirected_to travel_root_path
    
    get '/travel'
    assert_response :success
    assert_template 'travel/home'

  end
  
end


