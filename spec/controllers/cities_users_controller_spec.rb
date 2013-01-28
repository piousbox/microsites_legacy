
require 'spec_helper'

describe CitiesUsersController do

  before :each do
    User.clear
    @user = FactoryGirl.create :user
    sign_in :user, @user

    CitiesUser.all.each { |c| c.remove }
    
  end

  describe 'index' do
    it 'should GET index' do
      get :index
      response.should be_success
    end
  end

  describe 'new and create' do
    it 'should GET new' do
      get :new
      response.should be_success
    end

    it 'should POST create' do
      cu = {}
      post :create, :cities_user => cu
      response.should be_redirect
    end
  end
  
end
