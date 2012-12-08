require 'spec_helper'

describe Manager::TagsController do

  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    Gallery.all.each { |g| g.remove }
    User.all.each { |c| c.remove }

    @user = User.all[0]
    @admin = FactoryGirl.create :admin

    @city = FactoryGirl.create :rio

    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save

    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save


    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]

    sign_in @admin

  end

  describe 'sanity' do
    it 'can do' do
      true.should eql true
    end
  end

end
