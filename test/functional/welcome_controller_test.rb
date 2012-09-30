

class WelcomeControllerTest < ActionController::TestCase
  
  setup do
    setup_host
    
  end
  
  test 'get homepage' do
    get :homepage
    assert_response :success
    assert_template :homepage
    
  end
  
end