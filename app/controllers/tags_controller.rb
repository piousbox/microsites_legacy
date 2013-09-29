
class TagsController < ApplicationController

  def index
    authorize! :index, Tag.new
    # @feature_tags = Tag.features
    @tags = Tag.where( :is_trash => false, :is_public => true, :site_id => @site.id )
  end

  def show
    @tag = Tag.where( :name_seo => params[:tagname] ).first
    authorize! :show, @tag

    @galleries = @tag.galleries.public.order_by( :created_at => :desc ).page( params[:galleries_page] )
    @features = []
    @reports = @tag.reports.public.order_by( :created_at => :desc ).page( params[ :reports_page ] )
    @children_tags = @tag.children_tags
  end

end

