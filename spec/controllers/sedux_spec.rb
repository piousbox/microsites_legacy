
require 'spec_helper'

describe Manager::ReportsController do

  before :each do
    Tag.all.each { |c| c.remove }

    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user

    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio

    Report.all.each { |c| c.remove }
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save

    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save

    sign_in @user
    @sedux = Tag.where( :domain => 'blog.sedux.local' ).first
  end

  describe 'sedux' do
    
    it 'displays total number of sedux reports in manager footer' do
      get :index
      response.should be_success
      n = assigns( :n_sedux_reports )
      n.should_not eql nil

      expected = Report.where( :tag => @sedux ).length
      ( expected > 0 ).should be true
      n.should eql expected

    end

  end


end


