
require 'spec_helper'

describe Utils::VerificationController do

  before :each do
    setup_sites
  end

  it 'GETs one' do
    get :one
    response.should be_success
  end

end

