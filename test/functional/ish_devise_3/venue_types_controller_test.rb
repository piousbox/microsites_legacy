require 'test_helper'

class VenueTypesControllerTest < ActionController::TestCase
  
  setup do
    @venue_type = venue_types(:one)
		@admin = users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venue_types)
  end

  test "should show venue_type" do
    get :show, :id => @venue_type.to_param
    assert_response :redirect # have to put in current city first
    
    session[:current_city] = {}
    session[:current_city][:id] = 22
    session[:current_city][:name] = 'San Francisco'
    session[:current_city][:name_seo] = 'San_Francisco'
    
    get :show, :id => @venue_type.to_param
    assert_response :success
    
    assert_not_nil assigns :venue_type
    assert_not_nil assigns :venues
  end

  

end
