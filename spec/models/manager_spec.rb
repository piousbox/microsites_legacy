
require 'spec_helper'

describe Manager do

  before :each do
  end

  describe 'sanity' do
    it 'can be instantiated' do
      m = Manager.new
      m.should_not eql nil
    end
  end

end
