
require 'test_helper'
require 'total_ability'

  
class My::DaysControllerTest < ActionController::TestCase

  setup do
    one = Day.create :a1 => 'MyText', :a2 => 'a', :date => '2012-01-01'
    
    two = Day.create :a1 => 'MyText', :a2 => 'a', :date => '2012-02-01'
    two.save
    
    three = Day.create :a1 => 'MyText', :a2 => 'a', :date => '2012-03-01'
    three.save
    
    
    @day = one
    @user = users(:user)
		@admin = users(:admin)
    
    sign_in :user, @admin
  end

  test "should get index" do

    get :index
    assert_response :success
    assert_not_nil assigns(:days)
  end
  
#  test 'post search' do
#    date = '2011-02-01'
#    
#    existing = Day.find :all,
#      :conditions => { :date => date }
#    
#    assert_equal 'Day', existing.clas.name
#    post :search, :search_date => date
#    assert_response :success
#
#    assert_template :edit
#    
#    post :search, :search_date => '2012-01-01'
#    assert_response :success
#    assert_template :new
#  end

  test "should get new" do
    get :new
    assert_response :success
    assert_template :new
    
  end

  test "should create day" do
    
    assert_difference('Day.count') do
      post :create, :day => @day.attributes
    end

    assert_response :redirect
    assert_redirected_to dashboard_path
  end

  test "should show day" do
    
    
    get :show, :id => @day.to_param
    assert_response :success
  end

  test "should get edit" do
    
    
    get :edit, :id => @day.to_param
    assert_response :success
  end

  test "should update day" do
    
    put :update, :id => @day.to_param, :day => @day.attributes
    assert_redirected_to my_days_path
  end

end
