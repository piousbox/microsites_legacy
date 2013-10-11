require 'spec_helper'
describe 'Photos' do

  it 'multifile upload' do
    expect( :post => '/en/galleries/1a/multiphotos' ).to route_to( 'photos#j_create', :locale => 'en', :galleryname = '1a' )
  end

end


