
require 'spec_helper'

describe UsersController do
  
  before :each do
    User.all.each { |d| d.remove }

    @user = FactoryGirl.create :user
    
  end
  
  describe 'photos' do
    it 'shows my fucking photos' do
      sign_in :user, @user
      
      get 'photos'
      response.should be_success
      response.should render_template('photos')
      
    end
  end
end