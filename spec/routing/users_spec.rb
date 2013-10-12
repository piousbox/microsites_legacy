require 'spec_helper'
describe 'Users' do

  it 'resume' do
    expect( :get => '/en/users/pi/resume/print' ).to route_to( 'users#show', :locale => 'en', :print => true, :username => 'pi' )
    expect( :get => '/en/users/show/pi' ).to route_to( 'users#show', :locale => 'en', :username => 'pi' )
    expect( :get => '/en/users/pi/resume' ).to route_to( 'users#show', :locale => 'en', :username => 'pi' )
  end

end


