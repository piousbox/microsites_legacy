require 'spec_helper'

describe Manager::SitesController do

  before :each do
    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio
    @sf = FactoryGirl.create :sf

    User.all.each { |c| c.remove }
    @user = User.all[0]
    @admin = FactoryGirl.create :admin
    sign_in :user, @admin

    Tag.clear
    @tag = FactoryGirl.create :tag

    Report.all.each { |c| c.remove }
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save

    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save

    Gallery.all.each { |g| g.remove }
    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]

    Venue.all.each { |d| d.remove }
    @venue = FactoryGirl.create :venue

  end

  describe 'newsitems' do
    it 'should be able to delete a newsitem' do
      sign_in :user, @admin
      @site = Site.all[0]

      n = Newsitem.new
      n.report = Report.all[0]
      @site.newsitems << n
      flag = @site.save
      flag.should eql true

      n_old = @site.newsitems.to_a.length
      n_old.should_not eql 0
      
      newsitems = @site.newsitems.all
      delete :newsitem_destroy, :site_id => @site.id, :newsitem_id => newsitems.first.id
      response.should be_redirect

      n = Site.find(@site.id).newsitems.to_a.length
      ( n +1 ).should eql n_old
    end
  end

end
