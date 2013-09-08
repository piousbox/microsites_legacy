
require 'spec_helper'

describe TagsController do

  before :each do
    Tag.all.each { |t| t.remove }
    @tag = FactoryGirl.create :tag_technology
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

