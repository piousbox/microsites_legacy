
require 'spec_helper'

describe VideosController do

  before :each do
    City.all.each { |u| u.remove }
    City.create :name => 'San Francisco', :cityname => 'San_Francisco'

    User.all.each { |r| r.remove }
    @u = FactoryGirl.create :user

    Video.all.each { |v| v.remove }
    @v1 = FactoryGirl.create :v1
    @v2 = FactoryGirl.create :v2
    @v3 = FactoryGirl.create :v3
  end

  describe 'index' do
    it 'should' do
      get :index
      response.should be_success

      vs = assigns(:videos)
      vs.length.should be > 0

    end

    it 'should should only for a city' do
      get :index, :cityname => 'San_Francisco'
      vs = assigns(:videos)
      vs.each do |v|
        v.city.name.should eql 'San Francisco'
      end
      
    end

  end
  
end
