require 'test_helper'

class SiteTest < ActiveSupport::TestCase

  setup do
    Site.all.each { |s| s.remove }

  end

  test 'domain and language together are unique' do
    a = Site.new :name => 'a', :domain => 'pi.local', :lang => 'en'
    assert a.save

    b = Site.new :name => 'b', :domain => 'pi.local', :lang => 'pt'
    assert b.save, 'can save site with duplicate domain and unique lang.'

    c = Site.new :name => 'b', :domain => 'pi.local', :lang => 'pt'
    assert_equal false, c.save, 'Should not be able to save a site with matching domain AND lang'
    
  end

end


