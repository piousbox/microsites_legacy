
require 'spec_helper'

describe 'users/ link' do
  
  before :each do
    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site
    @site.is_resume_enabled = true
    @site.domain = 'pi.local'
    @site.save

    @request.host = 'pi.local'
  end

  it 'links properly if the site is user-enabled' do
    get '/en/sites/piousbox.com.html'
    response.status.should be(200)
    response.body.should have_content "<a href=\"http://pi.local/en/users\">Users</a>"
  end

  it 'links to piousbox.com if the site is not user-enabled' do
    @site.is_resume_enabled = false
    get '/en/sites/piousbox.com.html'
    response.status.should be(200)
    response.body.should have_content "<a href=\"http://piousbox.com/en/users\">Users</a>"
  end

end
