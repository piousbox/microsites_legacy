
require 'spec_helper'


describe Utils::SitemapsController do

  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    Gallery.all.each { |g| g.remove }

    @user = User.all[0]

    @city = FactoryGirl.create :rio

    @g = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2

  end

  describe 'do' do
    it 'renders sitemap' do

      assigns( false ).should eql true

    end
  end
end
