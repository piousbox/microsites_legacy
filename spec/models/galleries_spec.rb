
require 'spec_helper'

describe Gallery do

  before :each do
    Gallery.all.each { |u| u.remove }
    User.all.each { |u| u.remove }

    @user = FactoryGirl.create :user
  end

  describe 'galleries' do
    it 'saves username' do
      g = Gallery.new :name => 'asdf', :galleryname => 'wrgbdsfg', :user => @user
      flag = g.save
      flag.should eql true
      g.username.should_not eql nil
      g.username.should eql @user.username
    end
  end
end
