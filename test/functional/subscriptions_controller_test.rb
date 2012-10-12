
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
  
  
end
