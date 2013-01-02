

class Users::RegistrationsController < Devise::RegistrationsController

  skip_authorization_check

  before_filter :aaa
  
  def aaa
    ApplicationController.new.set_defaults
  end
  
end