require 'test_helper'

class StringTest < ActiveSupport::TestCase
  
  test 'to_simple_string' do
    string = 'Blah.blah'
    assert_equal 'Blah_blah', string.to_simple_string
    
  end
  
end
