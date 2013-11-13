require "spec_helper"

describe "redirection" do

  it 'show to view' do
    get "/ru/videos/view/5"
    response.should redirect_to( "/ru/videos/show/5" )
  end

end
