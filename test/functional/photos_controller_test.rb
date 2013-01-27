
require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

  setup do
    User.all.each { |d| d.remove}

  end

end
