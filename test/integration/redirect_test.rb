
require 'test_helper'

class RedirectTest < ActionDispatch::IntegrationTest

  fixtures :all

  setup do
    setup_photos
    setup_cities
  end

end


