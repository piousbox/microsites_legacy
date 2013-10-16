require "spec_helper"

describe "external redirection" do
  it "redirects to travel-guide.mobi" do
    get "/en/cities/travel-to/Rio"
    response.should redirect_to("http://travel-guide.mobi/en/cities/travel-to/Rio")
  end
end
