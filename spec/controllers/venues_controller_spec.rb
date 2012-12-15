
require 'spec_helper'

describe VenuesController do

  before :each do
    City.all.each { |u| u.remove }
    City.create :name => 'San Francisco', :cityname => 'San_Francisco'

    User.all.each { |r| r.remove }
    @u = FactoryGirl.create :user

    Venue.all.each { |v| v.remove }

  end

  describe 'index' do
    it 'should' do
      get :index
      response.should be_success

      vs = assigns(:venues)
      vs.length.should be > 0

    end

    it 'should should only for a city' do
      get :index, :cityname => 'San_Francisco'
      vs = assigns(:venues)
      vs.each do |v|
        v.city.name.should eql 'San Francisco'
      end

    end

  end

end
