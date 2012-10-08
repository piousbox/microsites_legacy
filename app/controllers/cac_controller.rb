

class CacController < ApplicationController
  
  layout 'cac'
  
  before_filter :frt5
  
  def home
    
    
    
  end
  
  def about
    
  end
  
  def services
    
  end
  
  def team
    
  end
  
  def contact
    
  end
  
  private
  
  def frt5
    @subscription = Subscription.new
    @message = Message.new
    @posts = []
  end
  
end