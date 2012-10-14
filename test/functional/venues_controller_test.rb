require 'test_helper'

class VenuesControllerTest < ActionController::TestCase
  setup do
    @venue = venues(:one)
		@user_one = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    
    venues = assigns :venues
    assert_not_nil venues
    assert venues[0].is_a? Venue
  end
  
  test 'get index_small' do
    get :index_small
    assert_response :success
    assert_not_nil assigns :idx_venues
  end

 
  test "should show venue" do
		assert_not_nil @venue[:name_seo]
		
    get :show, :name_seo => @venue[:name_seo]
    
    assert_response :success
    
    venue = assigns :venue
    assert_not_nil venue
    assert venue.is_a? Venue
    assert_not_nil venue.venue_type
    assert venue.venue_type.is_a? VenueType
    
    city = assigns :city
    assert_not_nil city
    assert city.is_a? City
    
    assert_not_nil :venues
    assert_not_nil :city
    
    assert_template :show
    assert_template :venues
    
    assert_select '.rate-this'
    assert_select '.share-this'
    assert_select '.disqus'
    
  end

end
