require 'test_helper'

class ReportTest < ActiveSupport::TestCase

	test "recommended" do
		tags = Tag.find([5, 6, 7])
		expected = Report.find([1, 2, 5, 10])
		result = Report.recommended(tags, 4)
		
	end
  
  test ".find_feature" do
    result = Report.find_feature( :limit => 2 )
    assert_not_nil result
    assert_equal 2, result.length 
    
    # without specifying the limit
    result = Report.find_feature
    assert_not_nil result
    assert_equal 5, result.length 
    
    result = Report.find_feature :lang => 'pt'
    assert_equal 'pt', result[0][:lang]
  end
  
  test ".find_in_city" do
    result = Report.find_in_city 22
    assert_not_nil result
    assert result.length > 2
  end

end
