

class TagsController < ApplicationController

  load_and_authorize_resource
  
  def index
    @tags = Tag.all.fresh.public
  end
  
  def show
    
    @tag = Tag.where( :name_seo => params[:name_seo] ).first

    @reports = @tag.reports.page( params[:reports_page] )
    @galleries = @tag.galleries
    
    @main_tag.children_tags.each_with_index do |child, idx|
      if @tag.name_seo == child.name_seo
        @tag_class = classes[idx]
      end
    end
    
  end
  
  
  
end