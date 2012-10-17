
require 'test_helper'

class Manager::GalleriesControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:one)
    @admin = users(:admin)
    @manager = users :manager
    
    @r = reports(:one)
  end
  
  test 'destroy' do
    assert false, 'todo'
  end
  

end
