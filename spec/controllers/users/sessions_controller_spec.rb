
require 'spec_helper'


describe Users::SessionsController do

  before :each do
    User.all.each { |u| u.remove }
    Day.all.each { |d| d.remove }
    Addressbookitem.all.each { |d| d.remove }

    @user = FactoryGirl.create :user

    @request.env["devise.mapping"] = Devise.mappings[:user]
  end


  describe 'sign in' do
    it 'should render proper layout' do
      layouts = [ 'layouts/organizer', 'layouts/organizer', 'layouts/organizer',
        'layouts/organizer', 'layouts/organizer',
        'layouts/cac', 'layouts/cac'
      ]
      [ 'organizer.local', 'organizer.annesque.com', 'qxt.local',
        'pi.local', 'piousbox.com',
        'cac.local', 'computationalartscorp.com' ].each_with_index do |h, idx|
        @request.host = h
        get :new
        # puts! @response.body
        response.should be_success
        response.should render_template(layouts[idx])
      end
    end
  end

end
