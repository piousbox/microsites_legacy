
require 'spec_helper'

describe WelcomeController do

  before :each do
    City.all.each { |u| u.remove }
    @city = City.create :name => 'San Francisco', :cityname => 'San_Francisco'

    User.all.each { |f| f.remove }
    @user = FactoryGirl.create :user

    Report.all.each { |r| r.remove }
    @feature_pt_1 = FactoryGirl.create :feature_pt_1
    @feature_ru_1 = FactoryGirl.create :feature_ru_1

  end

  describe 'home' do
    it 'should be sane' do
      true.should eql true
    end
  end
  
end
