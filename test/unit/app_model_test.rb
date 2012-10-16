
require 'test_helper'

class AppModelTest < ActiveSupport::TestCase
  
  setup do
    ;
  end
  
  test 'method list' do
    assert City.list
    assert Tag.list
  end
  
end


