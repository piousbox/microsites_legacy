
require 'spec_helper'

describe 'tags' do

  it 'shows tags in a site' do
    expect( :get => '/en/sites/pi.local/tags' ).to route_to( 'tags#index', :locale => 'en' )
    expect( :get => '/en/sites/pi.local/tags/page/1' ).to route_to( 'tags#index', :locale => 'en', :tags_page => '1' )
  end

end


