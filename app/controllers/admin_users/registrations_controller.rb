
class AdminUsers::RegistrationsController < Devise::RegistrationsController

  skip_authorization_check

end
