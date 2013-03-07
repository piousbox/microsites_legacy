
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

  describe 'actions' do
    it 'has the list of actions, or templates' do
      Gallery.actions.should eql [ 'show_mini', 'show_long', 'show_photo']
    end
  end
  
end
