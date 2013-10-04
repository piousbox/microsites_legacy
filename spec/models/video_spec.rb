require 'spec_helper'
describe Video do

  before :each do
    Video.all.each { |u| u.remove }   
    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
  end

  describe 'videos' do
    it 'should be ok' do
      v = Video.new
      v.youtube_id = '1'
      v.user = @user
      v.save.should eql true
      v.class.name.should eql 'Video'
    end
  end

  describe '#add_newsitem' do
    before :each do
      City.all.each { |c| c.remove }
      @city = FactoryGirl.create :city
      setup_sites
      Video.all.each { |v| v.remove }
      video = Video.create :user_id => @user.id, :youtube_id => '555', :city_id => @city.id, :site_id => @site.id
    end
    it 'for city' do
      City.find( @city.id ).newsitems.length.should eql 1
    end
    it 'for site' do
      Site.find( @site.id ).newsitems.length.should eql 1
    end
    
  end

end
