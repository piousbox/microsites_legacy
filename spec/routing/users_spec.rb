require 'spec_helper'
describe 'Users' do

  it 'print resume' do
    expect( :get => '/en/users/pi/resume/print' ).to route_to( 'users#show', :locale => 'en', :print => true, :username => 'pi' )
  end

end


