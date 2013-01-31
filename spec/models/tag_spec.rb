
require 'spec_helper'

describe Tagh do

  before :each do
    Tag.clear

  end

  describe 'tags' do
    it 'should give features' do
      Tag.clear
      @feature_tags = FactoryGirl.build_list( :feature_tag, 5 )
      @tags = FactoryGirl.build_list( :tag, 2 )

      result = Tag.features 3
      result.length.should eql 3
      result.each do |r|
        r.is_feature.should eql true
      end

      result = Tag.features
      result.length.should eql 4

    end
  end
end
