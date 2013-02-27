
require 'spec_helper'

describe Manager::VideosController do

  before :each do
    City.all.each { |u| u.remove }
    @city = FactoryGirl.create :sf

    User.all.each { |r| r.remove }
    @u = FactoryGirl.create :user
    sign_in :user, @u

    Video.all.each { |v| v.remove }
    @v1 = FactoryGirl.create :v1
    @v2 = FactoryGirl.create :v2
    @v3 = FactoryGirl.create :v3

    #
    # attributes
    #
    @video = { :descr => 'Test descr' }
    
    Site.each { |s| s.remove }
    @site = FactoryGirl.create :sedux_site

  end

  describe 'GET new' do
    it 'should GET' do
      get :new
      response.should be_success
      response.should render_template('new')
      assigns(:cities_list).should_not eql nil
      assigns(:tags_list).should_not eql nil
    end
  end

  describe 'create' do
    it 'can be put in a city' do
      Video.all.each { |v| v.remove }
      video = { :descr => 'Test descr', :city_id => City.all.first.id }
      post :create, :video => video
      response.should be_redirect

      result = Video.all.first
      result.city.name.should eql 'San Francisco'
    end

    it 'can have description' do
      post :create, :video => @video
      response.should be_redirect

      result = Video.where( :descr => @video[:descr] )
      result.length.should eql 1
    end

    it 'creates a newsitem for city' do
      @video[:city_id] = @city.id
      @city.newsitems.length.should eql 0
      post :create, :video => @video
      City.find( @city.id ).newsitems.length.should eql 1
    end

    it 'creates a newsitem for homepage' do
      @site.newsitems.to_a.length.should eql 0
      post :create, :video => @video
      Site.find( @site.id ).newsitems.length.to_a.should eql 1
    end

  end

end
