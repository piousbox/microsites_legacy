
require "spec_helper"

describe ApplicationHelper do
  describe "#image_flag" do
    it "returns the image flag" do
      expected = "<img alt=\"En\" src=\"/assets/flags/en.png\" />"
      # expected = image_tag('flags/en.png')
      expect(helper.image_flag('en')).to eql( expected )
    end
  end

  it '#image_city' do
    # expected = image_tag( 'icons/48x48/city.png' )
    expected = "<img alt=\"City\" src=\"/assets/icons/48x48/city.png\" />"
    expect( helper.image_city 'some_cityname' ).to eql( expected )
  end

end
