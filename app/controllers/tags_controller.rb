
class TagsController < ApplicationController
  
  def index    
    authorize! :index, Tag.new

    @feature_tags = Tag.all.where( :is_feature => true ).limit( 4 )
    @tags = Tag.all
    render :layout => @layout
  end
  
  def show
    @tag = Tag.where( :name_seo => params[:name_seo] ).first
    authorize! :show, @tag

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
