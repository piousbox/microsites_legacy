

require 'test_helper'
require 'total_ability'

class Manager::VenueTypesControllerTest < ActionController::TestCase

  setup do
    @v = venue_types(:one)
    @admin = users :admin
		sign_in :user, @admin
  end
  
  test 'get new' do
    get :new

    assert_response :success
    
    b = assigns :venue_types_list
    assert_not_nil b
  end

  test "should create venue_type" do
    v = { :name => '0986yhn765', :name_seo => '9oilkjhjjh' }
    
    assert_difference('VenueType.count') do
      post :create, :venue_type => v
    end

  end
  
  test "should get edit" do
		get :edit, :id => @v.to_param
    assert_response :success
    assert_template :edit
  end

  test "should update venue_type" do
    
    
    n = { :name => '0987654efgnm', :name_seo => '098754ewdfghjk' }
    
		put :update, :id => @v[:id], :venue_type => n
    new = VenueType.find_by_name n[:name]
    assert_not_nil new
    assert new.is_a? VenueType
    
  end
  
end