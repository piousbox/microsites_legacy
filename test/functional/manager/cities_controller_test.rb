

require 'test_helper'

class Manager::CitiesControllerTest < ActionController::TestCase

  setup do
    @user = users(:one)
    @admin = users(:admin)
    @manager = users :manager
    
    @city = cities :one
    
    sign_in :user, @manager
  end
  
  test 'get index' do
    get :index
    assert_response :success
    assert_template 'index'
    
    c = assigns :cities
    assert_not_nil c
    assert c[0].is_a? City
    
  end
  
  test 'mark features' do
    get :mark_features
    assert_response :success
    assert_template :mark_features
    
  end
  
  test "should create city" do

    assert_difference('City.count') do
      post :create, :city => { :name => 'test city name', 
				:name_seo => 'test_city_name', :country_id => 1, :is_public => 1,
				:is_trash => 0, :is_feature => 0 }
    end

    assert_redirected_to admin_cities_path
  end

  
  test "should get new" do 

		get :new
		assert_response :success
    assert_template :new
    
  end
  
  test 'post to create city' do
    
    city = {
      :name => '876543',
      :name_seo => 'h6ef4523rwe'
    }
    post :create, :city => city
    assert_response :redirect
    
    new = City.find_by_name city[:name]
    assert_not_nil new
    assert new.is_a? City
    
  end

  test "should get edit" do
		
    get :edit, :id => @city.to_param
    assert_response :success
  end

  test "should update city" do
		
    
		c = { :name => 'some name 66666', :name_seo => 'some_name_seo_09876' }
    
    put :update, :id => @city.to_param, :city => c
    result = City.find_by_name_seo c[:name_seo]
    assert_equal c[:name], result[:name]
  end
  
  test "should set user_id upon create" do
		city = {:name => 'asdfq3rf123', :name_seo => 'a1wqfas', :country_id => 5}

		post :create, :city => city

		# check user id
		result = City.find_by_name city[:name]
    assert_not_nil result
		assert_equal @admin.id, result[:user_id], 'user_id must be saved upon create'
	end
  
end
