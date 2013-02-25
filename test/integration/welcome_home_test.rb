
require 'test_helper'

class WelcomeHomeTest < ActionDispatch::IntegrationTest
  fixtures :all

  test 'redirect to piousbox.com from mobi and ish' do
    host! 'piousbox.com'
    
    get '/'
    assert_response :success
    assert_template 'welcome/home'

  end
  
end


