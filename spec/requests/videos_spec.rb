require "spec_helper"

describe "redirection" do

  it 'show to view' do
    get "/ru/videos/view/5"
    response.should redirect_to( "/ru/videos/show/5" )
  end

  it 'in tags' do
    get '/pt/videos/in-tag/tagname'
    response.should redirect_to( '/pt/tags/show/tagname' )
  end

end
