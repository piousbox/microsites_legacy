
require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  
  setup do
    ;
  end

  test 'subscribe' do
    result = Subscription.where( :name => 'blah blah' ).each { |x| x.remove }
    assert_equal 0, result.count
    
    s = {}
    s[:name] = 'blah blah'
    s[:email] = 'email@email.email'
    
    post :create, :subscription => s
    assert_response :success
    assert_template :success
    
    result = Subscription.where( :name => 'blah blah' ).first
    assert_not_nil result
    assert_equal s[:email], result.email
    
  end
  
  
  #  test "should get new" do
#    get :new
#    assert_response :success
#  end
#  
#  test 'store referrer' do
#    referrer = 'http://test.com/sessions/new'
#    one = {}
#    one[:email] = 'mysql@mysql.com'
#    @request.env['HTTP_REFERER'] = referrer
#    
#    assert_difference('Subscription.count') do
#      post :create, :subscription => one
#    end
#    
#    result = Subscription.find_by_email(one[:email])
#    assert_equal referrer, result[:referrer]
#  end
#
#  test "should create subscription" do
#    assert_difference('Subscription.count') do
#      post :create, :subscription => @subscription.attributes
#    end
#
#    assert_response :success
#    assert_template 'success'
#  end
end
