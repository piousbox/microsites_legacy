
require 'test_helper'

class DaysControllerTest < ActionController::TestCase
  
  setup do
    @request.host = 'travel.local'
    @user = FactoryGirl.create :user
    session[:current_user] = @user
    sign_in @user
    
    Day.all.each { |d| d.remove }
    @d = FactoryGirl.create :day
  end
  
#  test 'get new' do
#    get :new
#    assert_response :success
#    assert_template :new
#  end
  
  test 'search existing' do
    post :search, :date => @d.date
    assert_response :success
    assert_template :edit
  end
  
  test 'search non-existing' do
    post :search, :date => '0001-01-20'
    assert_response :success
    assert_template :new
  end
  
  test 'update day' do
    old_day = Day.where( :date => @d.date ).first
    a1 = old_day.a1
    assert_not_nil a1
    
    post :update, :day => { :date => @d.date, :a1 => '555' }, :id => @d._id
    assert_response :redirect
    
    new_a = Day.where( :date => @d.date ).first.a1
    assert_equal '555', new_a
  end
  
  test 'create day' do
    
    day = {}
    day[:a1] = 'Blah blah 1234asdfasdfv11111'
    day[:date] = '2012-05-05'
    
    old = Day.all.count
    post :create, :day => day
    assert_equal old + 1, Day.all.count
    
    assert_response :redirect
    assert_redirected_to :controller => :users, :action => :organizer
    
    d = Day.where( :a1 => day[:a1] ).first
    
  end
  
end