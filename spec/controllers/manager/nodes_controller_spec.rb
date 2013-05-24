
require 'spec_helper'

describe Manager::NodesController do

  render_views

  before :each do
    User.clear
    @manager = FactoryGirl.create :manager

    sign_in :user, @manager
  end

  describe 'push commit' do
    it 'does' do
      get :push_commit, :lang => :en
      response.should be_success
    end
  end

end

