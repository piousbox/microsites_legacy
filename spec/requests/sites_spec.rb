require "spec_helper"

describe "redirection of sites" do

  # i need this, legacy google crawl
  it "redirects newsitems html to non-html" do
    get "/en/sites/aaa.com.html/newsitems/page/1"
    response.should redirect_to("http://www.example.com/en/sites/aaa.com/newsitems/page/1")
  end

  it 'newsitems' do
    get '/pt/sites/blah.com/newspage/1'
    response.should redirect_to( '/pt/sites/blah.com/newsitems/page/1' )
  end
    
end


