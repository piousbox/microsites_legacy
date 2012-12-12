

class ManagerController < ApplicationController
  
  before_filter :require_manager
  
  layout 'manager'

  load_and_authorize_resource

  protected
  
  def require_manager
    unless 'test' == Rails.env
      authenticate_or_request_with_http_basic do |username, password|
        username == 'piousbox' && password == 'sho3b0x'
      end
    end

  end
  
end