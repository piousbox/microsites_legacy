require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  
  test "should have max count" do
    result = Todo.max_count
    expected = 5
    assert_equal expected, result
  end
end
