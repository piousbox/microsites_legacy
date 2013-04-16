require 'spec_helper'
describe Feature do
  before :each do
    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site

  end
  
  describe 'fields' do
    it 'has partial_name' do
      f = Feature.new
      f.partial_name = nnn = 'ads/partial_name'
      @site.features << f
      @site.save.should eql true
      @site = Site.find @site.id
      @site.features.length.should eql 1
      @site.features[0].partial_name.should eql nnn
    end
  end

end
