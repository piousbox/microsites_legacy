
class Econ::EconController < ApplicationController

  before_filter :require_manager

  layout 'manager'

  skip_authorization_check

end
