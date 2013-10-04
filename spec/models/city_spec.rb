require 'spec_helper'
describe City do

  it 'instantiates' do
    c = City.new
    c.class.name.should eql 'City'
  end

  describe '#add_newsitem' do
    before :each do
      City.all.each { |c| c.remove }
      @city = FactoryGirl.create :city
      Video.all.each { |v| v.remove }
      User.all.each { |u| u.remove }
      @user = FactoryGirl.create :user
    end
    it 'with video' do
      video = Video.create :user_id => @user.id, :youtube_id => '555', :city_id => @city.id
      City.find( @city.id ).newsitems.length.should eql 1
    end
  end
end

