
require 'spec_helper'

describe Utils::VerificationController do

  it 'GETs one' do
    get :one
    response.should be_success
  end

end

