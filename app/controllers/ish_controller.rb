

class IshController < ApplicationController
  
  layout 'ish'

  load_and_authorize_resource
  
  def home
    ;
  end
  
end