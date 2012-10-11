require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  
  setup do
#    @f = Fabricate :video
#    @ff = Fabricate :video_feature
    
  end
  
  test 'first_feature' do
    result = Video.first_feature
    assert_not_nil result
    assert_equal Video, result.class
  end
  
end
