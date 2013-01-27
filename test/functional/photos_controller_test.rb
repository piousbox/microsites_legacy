
require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

  setup do
    User.all.each { |d| d.remove}

  end

  test 'cannot view private photo' do
    assert false, 'todo'
  end

end
