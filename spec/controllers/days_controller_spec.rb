
require 'spec_helper'


describe DaysController do
  
  before :each do
    User.all.each { |u| u.remove }
    Day.all.each { |d| d.remove }
  end
  
  describe 'days' do
    it 'should save current user when creating a day' do
      
      u = FactoryGirl.create :user
      sign_in u
      
      day = {
        :date => '1988-01-01',
        :a1 => 'blah blah'
      }
      post :create, :day => day
      # response.should be_success
      
      Day.where( :date => '1988-01-01' ).length.should eql 1
      result = Day.where( :date => '1988-01-01' ).first
      result.user.should eql u
      
    end
  end
end
