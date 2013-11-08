require 'spec_helper'
describe Tag do

  before :each do
    Tag.unscoped.each { |t| t.remove }
    FactoryGirl.create :tag1
    FactoryGirl.create :tag2
  end

  describe 'tags' do

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
