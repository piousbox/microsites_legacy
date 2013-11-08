
class TagsController < ApplicationController

  caches_page :index, self::CACHE_OPTIONS
  caches_page :show, self::CACHE_OPTIONS

  def index
    authorize! :index, Tag.new
    # @feature_tags = Tag.features
    @tags = Tag.where( :site_id => @site.id, :parent_tag => nil )
  end

  def show
    @tag = Tag.where( :name_seo => params[:tagname] ).first
    authorize! :show, @tag

    @galleries = @tag.galleries.where( :is_public => true, :is_trash => false ).order_by( :created_at => :desc ).page( params[:galleries_page] )
    @features = []
    @reports = @tag.reports.where( :is_public => true, :is_trash => false ).order_by( :created_at => :desc ).page( params[ :reports_page ] )
    @children_tags = @tag.children_tags
  end

end

