require "spec_helper"

describe "external redirection" do

  it "redirects sitemap" do
    get "/en/sites/aaa/sitemap.xml"
    response.should redirect_to("http://example.com/en/sitemap.xml")
  end

end


