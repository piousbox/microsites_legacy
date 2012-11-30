

class Utils::VerificationController < ApplicationController

  layout false

  def one
    headers['Content-Type'] = 'text/plain'

    respond_to do |format|
      format.html do
        render 'utils/google_cac'
      end
    end
  end


end

