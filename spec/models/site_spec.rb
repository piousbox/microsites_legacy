require 'spec_helper'
describe Site do

  before :each do
    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site
  end

  describe 'Normal' do
    before :each do 
      Site.all.each { |s| s.remove }
    end

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

  describe '#add_newsitem' do
    before :each do
      User.all.each { |u| u.remove }
      @user = FactoryGirl.create :user
    end

    it 'for video' do
      Video.all.each { |v| v.remove }
      Video.all.length.should eql 0
      video = Video.create :youtube_id => 5, :user_id => @user.id
      @site.newsitems.length.should eql 0
      @site.add_newsitem video
      result = Site.find( @site.id )
      result.newsitems.length.should eql 1
      result = result.newsitems[0]
      result.video_id.should eql video.id
    end

  end
  
end



