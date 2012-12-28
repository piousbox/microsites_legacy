
require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test 'old index.php route' do
    get '/index.php/events/calendar/everything/anything/after/anything/yet/any:thing.gfr/asdf/asdf.dfsdf.ss'
    assert_response :redirect
    assert_redirected_to '/'
    get '/index.php'
    assert_response :redirect
    assert_redirected_to '/'
  end
end


