
# manager countries ctrl test

require 'test_helper'

class Manager::CountriesControllerTest < ActionController::TestCase
  
  setup do
    @country = countries(:one)
    @admin = users(:admin)
    
    sign_in :user, @admin
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countries)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_template :new
    
  end

  test "should create country" do
    
    c = { :name => '45678', :name_seo => '09876' }

    assert_difference('Country.count') do
      post :create, :country => c
    end

    assert_redirected_to manager_countries_path
    
  end

  test "should get edit" do
    get :edit, :id => @country.to_param
    assert_response :success
    assert_template :edit
  end

  test "should update country" do
    c = { :name => '0iucxcvbnm' }
    
    put :update, :id => @country.to_param, :country => c
    
    
    
    new = Country.find_by_name c[:name]
    assert_not_nil new
    assert new.is_a? Country
    
  end

end
