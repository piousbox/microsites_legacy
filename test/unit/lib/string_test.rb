require 'test_helper'

class StringTest < ActiveSupport::TestCase
  
  test 'to_simple_string' do
    string = 'Blah.blah'
    assert_equal 'blah-blah', string.to_simple_string
    
  end
  
end
