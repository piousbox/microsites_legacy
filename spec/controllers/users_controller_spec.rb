
require 'spec_helper'

describe UsersController do
  
  before :each do
    @user = User.all[0]
    
  end
  
  describe 'photos' do
    it 'shows my fucking photos' do
      sign_in @user
      
      get 'photos'
      response.should be_success
      response.should render_template('photos')
      
    end
  end
end