#
#
#require 'test_helper'
#
#class VenuesControllerTest < ActionController::TestCase
#  
#  setup do
#    
#    @venue = FactoryGirl.create :venue
#    
#    @user_one = FactoryGirl.create(:user)
#    @manager = FactoryGirl.create(:manager)
#    @admin = FactoryGirl.create(:admin)
#    
#    sign_in :user, @admin
#  end
#
#
#  test 'get index' do
#    get :index
#    
#    assert_response :success
#    venues = assigns :venues
#    assert_not_nil venues
#    assert venues[0].is_a? Venue
#  end
#  
#  test 'get new' do
#    
#    get :new
#    assert_response :success
#    assert_template :new
#    assert_template :manager
#  end
#  
#  test 'post create (a new venue)' do
#    
#    v = {}
#    v[:name] = 'name-45876543'
#    v[:name_seo] = 'y5bhgrefvwds'
#    
#    assert_difference('NoVenue.count') do
#      put :create, :venue => { :name => v[:name], :name_seo => v[:name_seo] }
#    end
#    
#    new = NoVenue.where(:name => v[:name]).first
#    assert_equal 'NoVenue', new.class.name
#    
#  end
#
#  test "should get edit" do
#    get :edit, :id => @venue[:id]
#    assert_response :success
#
#    assert_template :manager
#    assert_template :edit
#    assert_not_nil assigns :venue
#  end
#
#  test "should update venue" do
#    @v = venues(:two)
#		@v[:descr] = 'asdfiiiiik'
#    
#    put :update, { :id => @v.id, :venue => { :descr => @v[:descr] } }
#    
#    assert_response :redirect
#    assert_redirected_to manager_venues_path
#    
#		result = Venue.find_by_descr @v[:descr]
#		assert_not_nil result
#  end
#  
#  test 'validates name' do
#    new_venue = Venue.new
#    assert !new_venue.valid?
#    new_venue[:name_seo] = 'aaa'
#    assert !new_venue.valid?
#    new_venue[:name] = 'Aaa'
#    assert new_venue.valid?
#  end
#
#end
