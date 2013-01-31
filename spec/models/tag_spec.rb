
require 'spec_helper'

describe Tag do

  before :each do
    ;
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
  end
end
