

class BlogController < ApplicationController

  load_and_authorize_resource

  before_filter :set_tags

  layout 'blog'

  def show
    unless params[:name_seo].blank?
      @report = Report.where( :name_seo => params[:name_seo] ).first
    else
      @report = Report.find params[:id]
    end

    respond_to do |format|
      format.html
      format.json do
        if @report.photo
          @report[:photo_url] = @report.photo.photo.url(:thumb)
        end
        render :json => @report
      end
    end

  end
  
  def home
    
    @reports = Report.fresh.public.where( :domain => @domain )
    @reports = Report.fresh.public
    if params[:keyword]
      @reports = @reports.where( :name => /#{params[:keyword]}/i )
    end
    @reports = @reports.order_by( :created_at => :desc ).page( params[:reports_page] )

    @galleries = Gallery.fresh.public.where( :tag => @tag )
    if params[:galleries_keyword]
      @galleries = @galleries.where( :name => /#{params[:galleries_keyword]}/i )
    end
    @galleries = @galleries.order_by( :created_at => :desc ).page( params[:galleries_page] )
    
  end

  def index
    ;
  end

  def about
    ;
  end
  
  def privacy
    ;
  end

  private

  def set_tags
    @tag = Tag.where( :domain => @domain ).first
    @tags = Tag.all.where( :parent_tag => @tag ).order_by( :name => :desc ) || []

  end
  
end