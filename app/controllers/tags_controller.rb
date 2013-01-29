
class TagsController < ApplicationController

  load_and_authorize_resource
  
  def index
    @feature_tags = Tag.all.where( :is_feature => true ).limit( 4 )
    @tags = Tag.all.page( params[:tags_page] )
    render :layout => @layout
  end
  
  def show
    @tag = Tag.where( :name_seo => params[:name_seo] ).first

    @reports = @tag.reports.all.page( params[:reports_page] )
    @galleries = @tag.galleries.all.page( params[:galleries_page] )
    @videos = @tag.videos.all

    @main_tag = Tag.where( :domain => @domain ).first || Tag.new
    @main_tag.children_tags.each_with_index do |child, idx|
      if @tag.name_seo == child.name_seo
        @tag_class = classes[idx]
      end
    end

    render :layout => @layout
  end

end
