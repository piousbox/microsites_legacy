
require 'spec_helper'

describe Manager::TagsController do

  render_views

  before :each do
    @domain = 'piousbox.com'

    Tag.clear
    @tag = FactoryGirl.create :tag
    @tag1 = FactoryGirl.create :tag1
    @tag2 = FactoryGirl.create :tag2
    @tag2.parent_tag = @tag
    @tag2.save
    
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
      tags.each_with_index do |tag, idx|
        unless idx + 1 == tags.length
          tags[idx].name_en.should be <= tags[idx + 1].name_en
        end
      end
    end

    it 'should display first only tags with no parent' do
      get :index
      tags = assigns :tags

      Tag.all.length.should_not eql tags.length
      tags.each do |tag|
        tag.parent_tag.should eql nil
      end
    end

    it 'should display at least one child tag' do
      get :index

      flag = false
      assigns(:tags).each do |tag|
        if tag.children_tags.length >= 1
          assert_select('.children-tags')
          flag = true
        end
      end
      flag.should eql true
    end
  end

  describe 'new & create' do
    it 'should GET new' do
      get :new
      response.should be_success
      response.should render_template( 'new' )
    end
    
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

  describe 'show' do
    it 'GET show' do
      get :show, :id => Tag.all[0].id
      response.should render_template('tags/show')
      assigns(:reports).should_not eql nil
      assigns(:reports).each do |report|
        report.is_trash.should eql false
      end
    end
  end

  describe 'edit' do
    it 'lists tags for parent tags in GET edit' do
      get :edit, :id => @tag1.id
      assigns(:tags_list).should_not eql nil
      assigns(:tags_list).length.should >= 1
    end

    it 'lets you put a tag as a child tag' do
      tag_id = @tag1.id
      tag = { :parent_tag_id => @tag2.id }
      post :update, :id => tag_id, :tag => tag
      response.should be_redirect

      result = Tag.find tag_id
      result.parent_tag.name.should eql @tag2.name
    end
  end
  
end
