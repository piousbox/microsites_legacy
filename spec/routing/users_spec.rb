require 'spec_helper'
describe 'Users' do

  it 'print resume' do
    expect( :get => '/en/users/pi/resume/print' ).to route_to( 'users#', :locale => 'en', :print => true, :username => 'pi', :action => 'show' )
  end

end


