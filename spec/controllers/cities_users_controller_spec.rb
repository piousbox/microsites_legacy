
require 'spec_helper'

describe CitiesUsersController do

  before :each do
    User.clear
    @user = FactoryGirl.create :user
    sign_in :user, @user

  end

  describe 'index' do
    it 'should GET index' do
      get :index
      response.should be_success
      response.should render_template('index')
    end
  end

  describe 'new and create' do
    it 'should GET new' do
      get :new
      response.should be_success
      response.should render_template('new')
    end

    it 'should POST create and increment the CU count by one' do
      City.all.each { |c| c.remove}
      @city = FactoryGirl.create :city

      CitiesUser.all.each { |c| c.remove }

      cu = { :name => 'name', :city_id => @city.id }
      post :create, :cities_user => cu
      
      response.should be_redirect
      n_new = CitiesUser.all.length
      n_new.should eql 1
    end
  end
  
end
