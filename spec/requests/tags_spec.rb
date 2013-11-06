require "spec_helper"

describe "redirection of tags" do

  it "redirects from non-site namespaced to site-namespaced" do
    get "/tags"
    response.should redirect_to("http://www.example.com/en/sites/example.com/tags")
    get '/en/tags'
    response.should redirect_to("http://www.example.com/en/sites/example.com/tags")
  end

  it 'redirects tags view' do
    get '/en/tags/blah-blah'
    response.should redirect_to( 'http://www.example.com/en/tags/view/blah-blah' )
  end

end
