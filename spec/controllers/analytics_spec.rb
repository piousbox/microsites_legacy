require 'spec_helper'
describe SitesController do
  render_views
  before :each do
    setup_sites
  end

  describe "analytics group" do
    it 'should render the piousbox.com analytics' do
      @request.host = 'piousbox.com'
      get :show, :domain => 'piousbox.com'
      assert_select( "#analytics_pi" )
    end
  end

end
