
require 'spec_helper'


describe Photo do

  before :each do
    Photo.all.each { |p| p.remove }
  end

  
end
