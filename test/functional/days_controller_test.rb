
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
  
  test 'search existing' do
    post :search, :date => @d.date
    assert_response :redirect
    assert_template :edit
  end
  
  test 'search non-existing' do
    post :search, :date => '0001-01-20'
    assert_response :redirect
    assert_template :new
  end
  
  test 'create day' do
    
    day = {}
    day[:a1] = 'Blah blah 1234asdfasdfv11111'
    day[:date] = '2012-05-05'
    
    assert_difference(Day.all.count, 1) do
      post :create, :day => day
    end
    
    assert_response :redirect
    assert_redirected_to :action => :organizer
    
    d = Day.where( :a1 => day.a1 ).first
    assert_equal @user.username, d.user.username
    
  end
  
end