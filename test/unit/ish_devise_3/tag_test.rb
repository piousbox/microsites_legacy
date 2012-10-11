require 'test_helper'

class TagTest < ActiveSupport::TestCase
  
  test 'index_small' do
    result = Tag.index_small
    assert_equal 1, result[0][:id]
  end
  
  test 'features' do
    result = Tag.features 3
    assert_equal 3, result.length
    assert 1 == result[0][:is_feature] || true == result[0][:is_feature]
    
    result = Tag.features
    assert_equal 4, result.length
  end
  
end
