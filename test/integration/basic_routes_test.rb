require 'test_helper'
class BasicRoutesTest < ActionDispatch::IntegrationTest
  #  fixtures :all

  test 'locale redirect' do
    get '/blahblah'
    assert_response :redirect
    assert_redirected_to '/en/blahblah'
  end

  test 'nonexisting route to 500 error' do
    get '/en/blahblah'
    assert_response :success
    assert_equal '/en/blahblah', path
  end
  
end


