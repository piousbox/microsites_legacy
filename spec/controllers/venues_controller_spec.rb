require 'spec_helper'
describe VenuesController do
  render_views
  before :each do
    City.all.each { |u| u.remove }
    @city = @sf = FactoryGirl.create :sf

    User.all.each { |r| r.remove }
    @user = FactoryGirl.create :user

    Report.all.each { |r| r.remove }
    @report = FactoryGirl.create :report

    Venue.all.each { |v| v.remove }
    @v = FactoryGirl.create :venue
    @venue = @v

    Gallery.all.each { |g| g.remove }
    @gallery = FactoryGirl.create :gallery
    @pi_gallery = FactoryGirl.create :pi_gallery

    setup_sites
  end

  describe 'show' do
    it 'should show json' do
      @v.profile_photo.should eql nil
      get :show, :name_seo => @v.name_seo, :format => :json
      response.should be_success
    end

    it 'should show html' do
      @v.profile_photo.should eql nil
      @v.name_seo.should_not eql nil
      get :show, :name_seo => @v.name_seo
      response.should be_success
      response.should render_template('venues/show')
      assigns('reports').should_not eql nil
    end

    it 'should have map canvas' do
      get :show, :name_seo => @v.name_seo
      assert_select '#venues_show_canvas'
    end

    it 'should show newsitems ordered by date desc' do
      get :show, :name_seo => @v.name_seo
      assigns(:newsitems).each_with_index do |item, idx|
        if idx != (assigns(:newsitems).length - 1)
          iitem = assigns(:newsitems)[idx+1]
          iitem.created_at.should be < item.created_at
        end
      end
    end
  end

  describe 'index' do
    it 'should' do
      get :index
      response.should be_success
      vs = assigns(:venues)
      vs.length.should be > 0
    end
    
    it 'shows venues in-city' do
      city = City.all[0]
      get :index, :cityname => city.cityname
      response.should render_template('venues/index')
      assigns(:venues).each do |venue|
        venue.city.cityname.should eql city.cityname
      end
    end

    it 'should should only for a city' do
      get :index, :cityname => 'San_Francisco'
      vs = assigns(:venues)
      vs.each do |v|
        v.city.name.should eql 'San Francisco'
      end
    end
  end

  describe 'news' do
    it 'should GET news' do
      get :news, :name_seo => @v.name_seo
      response.should be_success
      response.should render_template('venues/news')
      assigns( :newsitems ).should_not eql nil
    end
  end

  describe 'create' do
    it 'should GET new' do
      sign_in :user, @user
      get :new
      response.should be_success
      response.should render_template('venues/new')
    end

    it 'creates in city, with x, y, name, is_public' do
      sign_in :user, @user
      city = City.all[0]
      venue = { :x => '1.0', :y => '2.0', :is_public => true, :city_id => city.id, :name => 'Name is required' }
      put :create, :venue => venue
      response.should be_redirect
      
      result = Venue.where( :name => venue[:name] ).first
      result.class.name.should eql 'Venue'
      result.owner.username.should eql @user.username
      result.x.to_s.should eql venue[:x]
      result.y.to_s.should eql venue[:y]
      result.is_public.should eql true
      result.city.cityname.should eql city.cityname
    end
  end

  describe 'report' do
    it 'should GET report' do
      @report.venues << @venue && @report.save
      @report.venues.include?( @venue ).should eql true
      @report.save.should eql true
      @report.is_trash.should eql false
      @report.is_public.should eql true
      get :report, :venuename => @venue.name_seo, :reportname => @report.name_seo
      response.should be_success
      response.should render_template('venues/report')
    end
  end

  describe 'gallery' do
    it 'should GET gallery' do
      get :gallery, :galleryname => @gallery.galleryname, :venuename => @venue.name_seo
      response.should be_success
      response.should render_template('venues/gallery')
    end
  end

end


