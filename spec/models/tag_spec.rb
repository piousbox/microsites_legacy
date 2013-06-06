require 'spec_helper'
describe Tag do

  before :each do
    Tag.clear
    FactoryGirl.create :tag1
    FactoryGirl.create :tag2
  end

  describe 'tags' do
    it 'should give features' do
      Tag.clear
      @feature_tags = FactoryGirl.create_list( :feature_tag, 5 )
      @tags = FactoryGirl.create_list( :tag, 2 )

      result = Tag.features( 3 )
      result.to_a.length.should eql 3
      result.each do |r|
        r.is_feature.should eql true
      end

      result = Tag.features
      result.to_a.length.should eql 4
    end

    it 'generates name_seo before create' do
      r = Tag.new :name => 'lalala'
      r.save
      new = Tag.where( :name => r.name ).first
      new.name_seo.blank?.should eql false
      r.name.should eql r.name_seo
    end

    it 'has method `no_parent`' do
      ns = Tag.no_parent
      ns.length.should be > 1
      ns.each do |n|
        n.parent_tag.should eql nil
      end
    end

  end

end
