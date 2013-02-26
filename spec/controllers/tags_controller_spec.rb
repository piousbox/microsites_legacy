
require 'spec_helper'

describe TagsController do

  before :each do
    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user
    @anon = FactoryGirl.create :anon

    Tag.all.each { |c| c.remove }
    @feature_tags = FactoryGirl.create_list( :feature_tag, 5 )
    @tags = FactoryGirl.create_list( :tag, 2 )

    setup_sites
  end

  describe 'index' do
    it 'should GET list of topics' do
      get :index
      response.should be_success
    end

    it 'should have feature topics' do
      get :index
      assigns( :feature_tags ).should_not eql nil
      assigns( :feature_tags ).to_a.length.should eql 4
      n_feature_tags = Tag.all.where( :is_feature => true ).length
      n_feature_tags.should be > 4
    end

    it 'should have non-feature topics' do
      get :index
      assigns( :tags ).should_not eql nil
    end

    it 'only has public tags' do
      get :index
      assigns( :tags ).each do |tag|
        tag.is_public.should eql true
      end
      assigns( :feature_tags ).each do |tag|
        tag.is_public.should eql true
      end
    end
  end

end
