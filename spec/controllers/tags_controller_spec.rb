
require 'spec_helper'

describe TagsController do

  it 'GETs index' do
    get :index
    response.should render_template( 'tags/index' )
    assigns( :tags ).should_not eql nil
  end

  it 'GETs show' do
    get :show, :tagname => 'technology'
    response.should render_template( 'tags/show' )
    assigns( :tag ).should_not eql nil
  end

end

