

class WelcomeControllerTest < ActionController::TestCase
  
  test 'get homepage' do
    get :homepage
    assert_response :success
    assert_template :homepage
    
  end
  
end