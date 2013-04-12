require 'spec_helper'
describe City do
  before :each do
    ;
  end
  
  describe 'cities' do
    it 'should have unique cityname' do
      City.clear
      ['a', 'aa', 'aaa'].each do |name|
        ccc = City.new :name => name, :cityname => 'a', :name_en => name, :name_pt => name, :name_ru => name
        unless ccc.save
          puts! ccc.errors
        end
      end
      City.all.length.should eql 1
    end
  end

end
