
require 'spec_helper'

describe Newsitem do

  before :each do
    setup_sites
  end

  describe 'Normal' do

    it 'creates from params' do
      @site.newsitems << Newsitem.new({ :descr => 'blah blah' })
      @site.save.should eql true
      @site.newsitems[0].class.name.should eql 'Newsitem'
      n = Newsitem.from_params( @site.newsitems[0] )
      n.descr.should eql @site.newsitems[0].descr
    end

  end

end

