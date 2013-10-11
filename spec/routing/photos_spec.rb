require 'spec_helper'
describe 'Photos' do

  it 'multifile upload' do
    expect( :post => '/en/galleries/1a/multiadd' ).to route_to( 'photos#j_create', :locale => 'en', :galleryname => '1a', :format => :json )
    expect( :get => '/en/galleries/1a/multiadd' ).to route_to( 'photos#multinew', :locale => 'en', :galleryname => '1a' )
  end

end


