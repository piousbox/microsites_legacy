require 'spec_helper'
describe Venue do
  before :each do
    City.all.each { |c| c.remove }
    @sf = FactoryGirl.create :sf

    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user

    Venue.all.each { |u| u.remove }
    @v = FactoryGirl.create :venue
  end

  describe 'relations' do
    it 'belongs to an owner' do
      v = Venue.new :owner => @user
      v.save.should eql false # need name, name_seo, and city
    end
  end

end
