

class ManagerController < ApplicationController
  
  before_filter :require_manager
  
  layout 'manager'
  
  protected
  
  def require_manager
    unless 'test' == Rails.env
      authenticate_or_request_with_http_basic do |username, password|
        username == 'piousbox' && password == 'sho3b0x'
      end
    end

    unless current_user
      redirect_to sign_in_path
    end
  end
  
end