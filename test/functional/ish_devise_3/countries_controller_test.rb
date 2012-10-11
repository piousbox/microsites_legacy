
require 'test_helper'

class CountriesControllerTest < ActionController::TestCase

  setup do
    @country = countries(:one)
    @admin = users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:countries)
  end

  test "should show country" do
    assert_not_nil  @country[:name_seo]
    
    get :show, :name_seo => @country[:name_seo]
    
    assert_response :success
    assert_not_nil assigns :country
  end

end
