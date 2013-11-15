require 'test_helper'

class StringTest < ActiveSupport::TestCase
  
  test 'to_simple_string' do
    assert_equal 'blah-blah', 'Blah.blah'.to_simple_string
    assert_equal 'blah-blah', 'blah/blah'.to_simple_string
    assert_equal 'blah-blah', 'blah\blah'.to_simple_string
  end

end
