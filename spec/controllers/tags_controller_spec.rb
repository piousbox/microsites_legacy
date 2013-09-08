
require 'spec_helper'

describe TagsController do

  before :each do
    Report.all.each { |r| r.remove }
    @r = FactoryGirl.create :report
    @r1 = FactoryGirl.create :r1

    Gallery.all.each { |r| r.remove }
    @g = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1

    Tag.all.each { |t| t.remove }
    @tag = FactoryGirl.create :tag_technology
    @r.tag = @tag && @r.save
    @r1.tag = @tag && @r1.save
    @g.tag = @tag && @g.save
    @g1.tag = @tag && @g1.save

  end

  it 'GETs index' do
    get :index
    response.should render_template( 'tags/index' )
    assigns( :tags ).should_not eql nil
  end

  it 'GETs show' do
    tag = Tag.where( :name_seo => 'technology' ).first
    tag.should_not eql nil

    get :show, :tagname => 'technology'
    response.should render_template( 'tags/show' )
    assigns( :tag ).should_not eql nil

    # correct ordering of reports
    assigns( :reports ).length.should >= 2
    assigns( :reports )[0].created_at.should > assigns( :reports )[1].created_at

    # correct ordering of galleries
    assigns( :galleries ).length.should >= 2
    assigns( :galleries )[0].created_at.should > assigns( :galleries )[1].created_at
  end

end

