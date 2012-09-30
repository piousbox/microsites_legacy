

class Manager::TagsController < ApplicationController
  
  def homepage
    ;
  end
  
  def index
    @tags = Tag.all
  end
  
  def destroy
    Tag.all.each {|t| t.remove }
    Report.all.each {|t| t.remove }
    flash[:notice] = t('g.done')
    redirect_to :action => :homepage
  end
  
end