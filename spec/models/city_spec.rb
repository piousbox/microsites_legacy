
require 'spec_helper'


describe City do
  
  before :each do
    City.all.each { |u| u.remove }
  end
  
  describe 'cities' do
    it 'should have unique name' do
      ['a', 'aa', 'aaa'].each do |cityname|
        City.create :name => 'aaa', :cityname => cityname
      end
      City.all.length.should eql 1
    end
    
    it 'should have unique cityname' do
      ['a', 'aa', 'aaa'].each do |name|
        City.create :name => name, :cityname => 'a'
      end
      City.all.length.should eql 1
    end
  end
end
