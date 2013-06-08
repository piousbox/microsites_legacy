require 'spec_helper'
describe SitesController do
  render_views

  before :each do
    Site.all.each { |s| s.remove }
    @hosts_and_ids = [
                      [ 'piousbox.com', '#analytics_pi' ],
                      [ 'webdevzine.com', '#analytics_wdz' ],
                      [ 'sedux.net', '#analytics_sedux' ],
                      [ 'computationalartscorp.com', '#analytics_cac' ],
                      [ 'travel-guide.mobi', '#analytics_mobi' ],
                      [ 'annesque.com', '#analytics_pi' ]
                     ]
    @hosts_and_ids.each do |i|
      Site.create :domain => i[0], :lang => :en 
    end
  end

  describe "analytics group" do
    it 'should render the piousbox.com analytics' do
      @hosts_and_ids.each do |item|
        @request.host = item[0]
        get :show, :domain => item[0]
        assert_select( item[1] )
      end
    end
  end

end
