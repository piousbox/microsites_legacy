
require 'spec_helper'

describe 'Videos' do

  it 'adds video' do
    expect( :post => '/en/videos' ).to route_to( 'videos#create', :locale => 'en' )
    expect( :get => '/en/videos/new' ).to route_to( 'videos#new', :locale => 'en' )
  end

  it 'views video' do
    expect( :get => '/en/videos/show/blah' ).to route_to( 'videos#show', :youtube_id => 'blah', :locale => 'en' )
    expect( :get => '/en/videos' ).to route_to( 'videos#index', :locale => 'en' )
    expect( :get => '/en/videos/page/2' ).to route_to( 'videos#index', :videos_page => '2', :locale => 'en' )
  end

end


