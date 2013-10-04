require 'spec_helper'
describe City do

  it 'instantiates' do
    c = City.new
    c.class.name.should eql 'City'
  end

end

