
# user's organizer 

require 'spec_helper'
describe UsersController do
  render_views
  before :each do
    User.all.each { |d| d.remove }
    @user = FactoryGirl.create :user
    sign_in @user

    Report.clear
    @r1 = FactoryGirl.create :r1
    @r2 = FactoryGirl.create :r2
    @r3 = FactoryGirl.create :r3
    @r1.tag = @tag && @r1.save
    @r1.user = @user
    @r1.save
    @r3.tag = @tag && @r3.save
    @r3.user = @user
    @r3.save

    Gallery.all.each { |g| g.remove }
    @gallery = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2

    setup_sites
  end
  
  it 'GETs #organizer' do
    get :organizer
    response.should be_success
    response.should render_template( 'users/organizer' )
    assigns( :my_videos ).should_not eql nil
    assigns( :cities_list ).should_not eql nil
    assigns( :new_photo ).should_not eql nil
  end
  
  it 'has reports only belonging to this site' do
    get :organizer
    reports = assigns( :my_reports )
    Report.all.length.should > reports.length
    reports.should_not eql nil
    reports.each do |r|
      r.site.domain.should eql @site.domain
    end
  end
  
  it 'has galleries only belonging to this site' do
    get :organizer
    galleries = assigns( :my_galleries )
    Gallery.all.length.should > galleries.length
    galleries.should_not eql nil
    galleries.each do |g|
      g.site.domain.should eql @site.domain
    end
  end
  
end
