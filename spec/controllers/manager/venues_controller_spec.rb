require 'spec_helper'

describe Manager::VenuesController do

  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }

    User.all.each { |c| c.remove }
    @user = User.all[0]
    @admin = FactoryGirl.create :admin
    sign_in :user, @admin

    Tag.all.each { |c| c.remove }
    @tag = FactoryGirl.create :tag

    Gallery.all.each { |g| g.remove }

    

    @city = FactoryGirl.create :rio

    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save

    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save


    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]

    Venue.all.each { |d| d.remove }

  end

  describe 'create' do
    it 'can do' do
      Venue.all.each { |d| d.remove }
      Venue.all.length.should eql 0
      v = { :name => 'blah fffblah', :user => User.first }
      post :create, :venue => v      
      response.should be_redirect
      Venue.all.length.should eql 1
      
    end

  end

end
