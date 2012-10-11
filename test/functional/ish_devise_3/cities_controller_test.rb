require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  setup do
    @city = cities(:one)
		@city_2 = { :name => 'test city name',
				:name_seo => 'test_city_name', :country_id => 1, :is_public => 1,
				:is_trash => 0, :is_feature => 0 }
			
		@user = users(:user)
		@admin = users(:admin)
    
    @report = reports(:one)
  end
  
  test 'map' do
    get :map
    assert_response :success
    
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cities)
    assert_not_nil assigns(:feature_cities)
    
  end
  
  test "should show city" do
    # todays event
    sign_in :user, @user
    
    today = Event.new :city_id => @city[:id], 
      :date => DateTime.now, 
      :name => 'some name 2', 
      :name_seo => DateTime.new.to_s.to_slug,
      :descr => 'Some simple descr',
      :user_id => @user[:id]
    assert today.save
    
    get :show, :name_seo => @city[:name_seo]
    assert_response :success
    assert_template :show

    city = assigns :city
    
    greeter = city.greeter
    assert greeter.is_a? User
    
    today = city.today
    # assert_equal 'Event', today[0].class.name
    
  end

  
  
  test 'anchor link to calendar' do
    get :show, :id => @city[:id]
    assert_response :success
    
    assert_select '.su'
    assert_select '.mo'
    assert_select '.tu'
    assert_select '.we'
    assert_select '.th'
    assert_select '.fr'
    assert_select '.sa'
    
    assert_not_nil assigns :weekly_venues
  end
end
