
class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_defaults
  before_filter :set_action_name
  
  private
  
  def puts! arg
    puts '+++ +++'
    puts arg.inspect
  end
  
  
  def set_defaults
    
    @domain = request.host
    @main_tag = Tag.where( :domain => @domain ).first
    @main_tag ||= Tag.new
    
    @tag_class = ''
    
    @tags = []
    
  end
  
  
  def set_action_name
    begin
      @action_name = params[:controller].gsub('/', '_') + '_' + params[:action]
    rescue
    end
    
    begin
      @action_classes = params[:controller].gsub('/', '_')
    rescue
    end
    
  end
  
  
end
