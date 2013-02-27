
class TagsController < ApplicationController
  
  def index    
    authorize! :index, Tag.new

    @feature_tags = Tag.all.where( :is_feature => true, :is_public => true ).sort_by{ |f| [ f.weight, f.created_at ] }.reverse[0...4]
    @tags = Tag.all.where( :parent_tag => nil, :is_public => true ).reject { |t| @feature_tags.include? t }.reject { |r| r.reports.length == 0 && r.galleries.length == 0 }
    render :layout => @layout
  end
  
  def show
    @tag = Tag.where( :name_seo => params[:name_seo] ).first
    authorize! :show, @tag

    @reports = @tag.reports.where( :is_trash => false, :is_public => true ).page( params[:reports_page] )
    @galleries = @tag.galleries.where( :is_trash => false, :is_public => true ).page( params[:galleries_page] )
    @videos = @tag.videos.where( :is_trash => false, :is_public => true ).page( params[:videos_page] )

    render :layout => @layout
  end

end
