
require 'test_helper'

class OldRoutesTest < ActionDispatch::IntegrationTest
  fixtures :all

  test 'old index.php route' do
    get '/index.php/events/calendar/everything/anything/after/anything/yet/any:thing.gfr/asdf/asdf.dfsdf.ss'
    assert_response :redirect
    assert_redirected_to '/'

    get '/index.php/events/view/everything/anything/after/anything/yet/any:thing.gfr/asdf/asdf.dfsdf.ss'
    assert_response :redirect
    assert_redirected_to '/'
    
    get '/index.php'
    assert_response :redirect
    assert_redirected_to '/'

    get '/index.php/events/in/San_Francisco'
    assert_response :redirect
    assert_redirected_to '/cities/travel-to/San_Francisco'

    get '/venue_types/5'
    assert_response :redirect
    assert_redirected_to '/'
  end
  
end


