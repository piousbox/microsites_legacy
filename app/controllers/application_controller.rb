
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
    
    @main_tag = Tag.where( :domain => request.host ).first
    begin
      tag_ids = @main_tag.children_tags.map { |tag| tag._id } + [ @main_tag._id ]

      @reports = Report.where( :tag_id.in => tag_ids ).page params[:page]
    rescue
      @reports = Report.page params[:page]  
    end
    
    @tag_class = ''
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
