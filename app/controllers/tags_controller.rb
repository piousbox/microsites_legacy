

class TagsController < ApplicationController
  
  def index
    ;
  end
  
  def show
    classes = %w{ a b c d e f g h i }
    
    @tag = Tag.where( :name_seo => params[:name_seo] ).first
    
    @main_tag.children_tags.each_with_index do |child, idx|
      if @tag.name_seo == child.name_seo
        @tag_class = classes[idx]
      end
    end
    
  end
  
  
  
end