
require 'spec_helper'

describe Site do

  before :each do
    Site.all.each { |s| s.remove }

  end

  describe 'Normal' do
    it 'exists' do
      site = Site.new :domain => 'piousbox.com', :lang => 'en', :title => 'title', :subhead => 'subhead'
      site.save.should eql true
      site.class.name.should eql 'Site'
    end
  end

  describe 'class methods' do
    it 'lists' do
      Site.list.should_not eql nil
    end
  end

end
