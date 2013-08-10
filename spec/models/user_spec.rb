
require 'spec_helper'

describe User do

  describe 'Normal' do
    it 'creates newsitem' do
      u = User.new
      newsitem = Newsitem.new :photo => Photo.new
      u.create_newsitem newsitem
      u.save.should eql true
    end
  end

end

