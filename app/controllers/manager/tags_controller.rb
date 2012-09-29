

class Manager::TagsController < ApplicationController
  
  def homepage
    ;
  end
  
  def index
    @tags = Tag.all
  end
  
end