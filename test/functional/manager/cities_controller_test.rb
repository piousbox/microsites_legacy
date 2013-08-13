
require 'test_helper'

class Manager::CitiesControllerTest < ActionController::TestCase

  setup do
    User.clear
    @user = FactoryGirl.create :user
    @manager = FactoryGirl.create :manager

    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :nyc
    
    sign_in :user, @manager
  end
  
  test 'post update' do
    @city.is_feature = false
    assert @city.save

    city = { :is_feature => true }
    city_id = @city.id
    post :update, :city => city, :id => city_id
    assert_response :redirect

    new = City.find @city.id
    assert new.is_feature
    
  end
  
end
