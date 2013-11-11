require "spec_helper"

describe "redirection of sites newsitems" do

  it "redirects newsitems" do
    get "/en/sites/aaa.com.html/newsitems/page/1"
    response.should redirect_to("http://www.example.com/en/sites/aaa.com/newsitems/page/1")
  end

end


