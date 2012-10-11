
require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  
  setup do
    @controller = ReportsController.new
  end

  test "get home" do
    get :home
    assert_response :success
    assert_template :home
    
    fs = assigns :features
    assert_not_nil fs
    assert_equal 'NoReport', fs[0].class.name
    
  end
  
  test 'get dashboard' do
    get :dashboard
    assert_response :success
    assert_template :home
  end
  
end

