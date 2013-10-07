
require 'spec_helper'

describe User do

  before :each do
    User.clear
    @user = FactoryGirl.create :user
  end

  describe 'Normal' do
    it 'creates newsitem' do
      u = @user
      newsitem = Newsitem.new :photo => Photo.new, :descr => 'simple descr'
      u.create_newsitem :photo => newsitem
      u.save.should eql true
    end
  end

end

