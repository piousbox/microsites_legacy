
require 'test_helper'

class MiscTest < ActionController::TestCase
  
  setup do
    @controller = ReportsController.new
    
		@admin = users(:admin)

		sign_in :user, @admin
    
  end


  
end
