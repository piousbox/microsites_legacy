require 'test_helper'

class CommunityTest < ActiveSupport::TestCase
  
  setup do
#    @f = Fabricate :video
#    @ff = Fabricate :video_feature
    
  end
  
  test 'can create new' do
    c = Community.new
    assert_equal 'Community', c.class.name
  end
  
  
end


