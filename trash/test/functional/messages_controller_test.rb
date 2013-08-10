
require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  
  setup do
    setup_sites
  end

  test 'send' do
    from = 'from_email@email.email'
    
    result = Message.where( :from_email => from ).each { |x| x.remove }
    assert_equal 0, result.count
    
    s = {}
    s[:name] = 'blah blah'
    s[:from_email] = from
    
    post :create, :message => s
    assert_response :success
    assert_template :success
    
    result = Message.where( :name => s[:name] ).first
    assert_not_nil result
    assert_equal s[:from_email], result.from_email
    
  end
  
end
