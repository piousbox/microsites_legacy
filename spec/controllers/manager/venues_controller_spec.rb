require 'spec_helper'

describe Manager::VenuesController do

  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }

    User.all.each { |c| c.remove }
    @user = User.all[0]
    @admin = FactoryGirl.create :admin
    sign_in :user, @admin

    Tag.clear
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
    @venue = FactoryGirl.create :venue

  end

  describe 'show' do
    it 'can GET show' do
      get :show, :id => @venue.id
      response.should be_success
      response.should render_template( 'show' )
    end
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

  describe 'features' do
    it 'GET new' do
      get :new_feature, :name_seo => @venue.name_seo
      response.should be_success
      response.should render_template 'new_feature'
      assigns( :venue ).should_not eql nil
      assigns( :feature ).should_not eql nil
    end

    it 'should POST create' do
      feature = { :name => 'new feature name' }
      n_old = Venue.find( @venue.id ).features.length
      post :create_feature, :name_seo => @venue.name_seo, :feature => feature
      assert_response :redirect
      n_new = Venue.find( @venue.id ).features.length
      ( n_new - 1 ).should eql n_old
    end

    it 'shoud GET edit' do
      @venue.features << Feature.new({ :name => 'aaa' })
      get :edit_feature, :id => @venue.features[0].id, :name_seo => @venue.name_seo
      response.should be_success
      assigns( :venue ).should_not eql nil
      assigns( :feature ).should_not eql nil
    end

    it 'should POST update' do
      @venue.features << Feature.new({ :name => 'aa' })
      @venue.save
      @feature = @venue.features.first
      feature = { :name => 'the new feature name' }
      put :update_feature, :name_seo => @venue.name_seo, :id => @feature.id, :feature => feature
      response.should be_redirect
      result = Venue.find( @venue.id ).features.find( @feature.id )
      result.name.should eql feature[:name]
    end
  end

  describe 'newsitems' do
    it 'should GET new' do
      get :new_newsitem, :name_seo => @venue.name_seo
      response.should be_success
      response.should render_template 'new_newsitem'
      assigns( :venue ).should_not eql nil
      assigns( :newsitem ).should_not eql nil
    end
  end
  
end
