
require 'spec_helper'

describe VenuesController do

  before :each do
    City.all.each { |u| u.remove }
    City.create :name => 'San Francisco', :cityname => 'San_Francisco'

    User.all.each { |r| r.remove }
    @u = FactoryGirl.create :user

    Venue.all.each { |v| v.remove }
    @v = FactoryGirl.create :venue
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
    end
  end

  describe 'index' do
    it 'should' do
      get :index
      response.should be_success

      vs = assigns(:venues)
      vs.length.should be > 0

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
      get :news, :name_seo => @venue.name_seo
      response.should be_success
      response.should render_template('venues/news')
      assigns( :newsitems ).should_not eql nil
    end
  end
end
