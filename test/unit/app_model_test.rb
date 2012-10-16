




require 'test_helper'
require "open-uri"

class AppModelTest < ActiveSupport::TestCase
  
  setup do
    #    @f = Fabricate :video
    #    @ff = Fabricate :video_feature
    
  end
  
  test 'method list' do
    assert Cities.list
    
  end
  
end


