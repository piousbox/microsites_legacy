require 'test_helper'

class CommunityTest < ActiveSupport::TestCase
  
  test ".find_in_city" do
    result = Community.find_in_city 22
    assert_not_nil result
    assert result.length > 2
  end
end
