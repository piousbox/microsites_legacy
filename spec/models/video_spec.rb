
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
end
