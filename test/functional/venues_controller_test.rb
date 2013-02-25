
require 'test_helper'

class VenuesControllerTest < ActionController::TestCase
  setup do
    User.clear
		@user = FactoryGirl.create :user

    Venue.all.each { |v| v.remove }
    @venue = FactoryGirl.create :cac

    setup_sites
  end

  test "should get index" do
    get :index
    assert_response :success
    
    venues = assigns :venues
    assert_not_nil venues
    assert venues[0].is_a? Venue
  end
  
  test "should show venue" do
		assert_not_nil @venue[:name_seo]
		
    get :show, :name_seo => @venue[:name_seo]
    
    assert_response :success
    
    venue = assigns :venue
    assert_not_nil venue
    assert venue.is_a? Venue

    assert_template :show
    assert_template :venues
    
    # assert_select '.rate-this'
    assert_select '.share-this'
    # assert_select '.disqus'
    
  end

end
