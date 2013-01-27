
require 'spec_helper'

describe Manager::TagsController do

  before :each do
    @domain = 'piousbox.com'

    Tag.clear
    @tag = FactoryGirl.create :tag
    
    User.all.each { |c| c.remove }
    @user = User.all[0]
    @admin = FactoryGirl.create :admin
    sign_in @admin
    
    Gallery.all.each { |g| g.remove }
    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]

    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio

    Report.all.each { |c| c.remove }
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save
    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save

    Site.each { |s| s.remove }
    @site = FactoryGirl.create :site_piousbox
    @pi_local_site = FactoryGirl.create :site_pi

  end

  describe 'destroy' do
    it 'destroys' do
      t = Tag.all.first
      t.class.name.should eql 'Tag'
      n_old = Tag.all.length
      delete :destroy, :id => t.id
      new = Tag.where( :id => t.id ).first
      new.should eql nil
    end

    #    it 'destroys' do
    #      t = Tag.all.first
    #      t.is_trash.should be false
    #      delete :destroy, :id => t.id
    #      tt = Tag.find t.id
    #      tt.is_trash.should be true
    #    end

  end

  describe 'index' do
    it 'order by name' do
      get :index
      tags = assigns(:tags)

      tags.should_not eql []
      Tag.all.length.should eql tags.length
      
      tags.each_with_index do |tag, idx|
        unless idx + 1 == tags.length
          tags[idx].name.should be <= tags[idx + 1].name
        end
      end
    end
  end

  describe 'new & create' do
    it 'should put feature in homepage feature' do
      @request.host = @domain

      n_old = Tag.all.length
      n_features_old = Site.where( :domain => @domain ).first.features.length

      tag = { :name => 'test name', :name_seo => 'test-name', :descr => 'some descr.',
        :is_public => true, :is_trash => false, :is_feature => true,
        :domain => @domain
      }
      post :create, :tag => tag
      assert_response :redirect

      n_new = Tag.all.length
      n_features_new = Site.where( :domain => @domain ).first.features.length
      
      ( n_new - 1 ).should eql n_old
      ( n_features_new - 1 ).should eql n_features_old
      
    end
  end
  
end
