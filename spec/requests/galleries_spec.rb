require "spec_helper"

describe "galleries redirect" do

  it 'cities' do
    get "/ru/galleries/in-city/cityname"
    response.should redirect_to( "http://travel-guide.mobi/ru/cities/travel-to/cityname" )
  end

  it '#show, view' do
    get '/pt/galleries/view/blah'
    response.should redirect_to( '/pt/galleries/show/blah/0' )
  end

end
