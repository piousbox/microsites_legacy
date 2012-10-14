#require 'test_helper'
#
#class SubscriptionsControllerTest < ActionController::TestCase
#  setup do
#    @subscription = subscriptions(:one)
#  end
#
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
#
#end
