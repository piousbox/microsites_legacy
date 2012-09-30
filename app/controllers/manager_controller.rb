

class ManagerController < ApplicationController
  
  before_filter :require_admin
  
  protected
  
  def require_admin
    authenticate_or_request_with_http_basic do |username, password|
      username == 'piousbox' && password == 'sho3b0x'
    end
  end
  
end