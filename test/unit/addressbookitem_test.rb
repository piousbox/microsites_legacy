
require 'test_helper'

class AddressbookitemTest < ActiveSupport::TestCase

  def setup
    User.clear
    @user = FactoryGirl.create :user
    
  end

end
