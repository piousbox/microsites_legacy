
require 'spec_helper'


describe Video do

  before :each do
    Video.all.each { |u| u.remove }
  end

  describe 'videos' do
    it 'should be ok' do
      v = Video.new
      v.save.should.eql true
      v.class.name.should.eql 'Video'
    end
  end
end
