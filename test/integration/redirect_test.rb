
require 'test_helper'

class RedirectTest < ActionDispatch::IntegrationTest

  fixtures :all

  test 'travel controller to pi' do
    host! 'travel-guide.mobi'
    get '/travel'
    assert_redirected_to 'http://piousbox.com/travel'
    host! 'travel-guide.mobi'
    get '/about'
    assert_redirected_to 'http://piousbox.com/about'

    host! 'qxt.local'
    get '/cities'
    assert_redirected_to 'http://piousbox.com/cities'
    host! 'qxt.local'
    get '/cities/travel-to/San_Francisco'
    assert_redirected_to 'http://piousbox.com/cities/travel-to/San_Francisco'
  end

end


