
class SpecRunnerController < ApplicationController

  layout false
  
  def all
    authorize! :spec_all, Manager.new

  end

  def which
    authorize! :spec_which, Manager.new

  end

end
