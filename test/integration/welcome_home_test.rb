
require 'test_helper'

class WelcomeHomeTest < ActionDispatch::IntegrationTest
  fixtures :all

  test 'redirect to piousbox.com from mobi and ish' do
    host! 'travel-guide.mobi'
    get '/'
    assert_response :redirect
    assert_redirected_to 'http://piousbox.com/'

    host! 'piousbox.com'
    get '/'
    assert_response :redirect
    
    assert_redirected_to 'http://piousbox.com/travel?locale=en'
    get '/travel'
    assert_response :success
    assert_template 'travel/home'

  end
  
end


