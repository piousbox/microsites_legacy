require "spec_helper"

describe "external redirection" do

  it 'to travel-guide.mobi' do
    get "/en/venues/everything/1/2/3"
    response.should redirect_to( "http://travel-guide.mobi/en/venues/everything/1/2/3" )
  end

  it 'redirects venues/index to cities/show' do
    get "/en/venues/in-city/blahblah"
    response.should redirect_to( "http://travel-guide.mobi/en/cities/travel-to/blahblah" )
  end

  it 'redirects venues/show' do
    get "/en/venues/show/some-venue"
    response.should redirect_to( "http://travel-guide.mobi/en/venues/show/some-venue" )
    # pt
    get "/pt/venues/show/some-venue"
    response.should redirect_to( "http://travel-guide.mobi/pt/venues/show/some-venue" )
  end

  it 'redirects gallery' do
    # URL: http://piousbox.com/en/venues/cac/galleries/show/webdev-screenshots
    get "/en/venues/cac/galleries/show/webdev-screenshots"
    response.should redirect_to( "/en/galleries/show/webdev-screenshots/0" )
  end

end
