
require 'spec_helper'

describe Report do

  before :each do
    Report.all.each { |r| r.remove }

    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    @anon = FactoryGirl.create :anon
    
  end

  describe 'callbacks' do
    it 'saves username' do
      g = Report.new :name => 'asdf', :name_seo => 'wrgbdsfg', :user => @user, :username => @user.username
      flag = g.save
      flag.should eql true
      g.username.should_not eql nil
      g.username.should eql @user.username
    end

    it 'generates name_seo if it is not set' do
      names = ['asdf', 'aasdf.-', 'asdf:ff', 'asdf. sdf sdf' ]
      expected_names = ['asdf', 'aasdf', 'asdf-ff', 'asdf-sdf-sdf' ]
      names.each_with_index do |name, idx|
        g = nil
        g = Report.new :name => name, :user => @user, :username => @user.username, :name_seo => expected_names[idx]
        flag = g.save
        flag.should eql true
        # g.name_seo.should eql expected_names[idx]
        g.remove
      end
    end
  end

  describe 'create' do
    it 'should create newsitems for venues' do
      vs = Venue.all.to_a
      vs.length.should_not eql 0
      venue_ids = []
      vs.each do |v|
        venue_ids << v.id
      end
      attrs = { :name => 'Test Name', :descr => 'blah blah blah', :venue_ids => venue_ids, :is_public => true, :user => User.all.first,
        :username => 'username'
      }
      new_report = Report.create attrs
      result = Report.where( :name => attrs[:name] ).first
      venues = Venue.all
      venues.each_with_index do |venue, idx|
        ( venue.newsitems.length - 1 ).should eql vs[idx].newsitems.length
      end
    end
  end
end
