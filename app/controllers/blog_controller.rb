

class BlogController < ApplicationController

  load_and_authorize_resource

  before_filter :set_tags
  
  def home
    @reports = Report.fresh.public.where( :domain => @domain ).sort( :created_at => :desc ) # .page( params[:reports_page] )
    render :layout => 'blog'
  end

  def show
    unless params[:name_seo].blank?
      @report = Report.where( :name_seo => params[:name_seo] ).first
    else
      @report = Report.find params[:id]
    end

    respond_to do |format|
      format.html do
        render :layout => 'blog'
      end

      format.json do
        if @report.photo
          @report[:photo_url] = @report.photo.photo.url(:thumb)
        end
        render :json => @report
      end
    end

  end
  
  def index
    @reports = Report.fresh.public.where( :domain => @domain )
    if params[:keyword]
      @reports = @reports.where( :name => /#{params[:keyword]}/ )
    end
    @reports = @reports.sort( :created_at => :desc ) # .page( params[:reports_page] )
    render :layout => 'blog'
  end

  def about
    ;
  end
  
  def privacy
    ;
  end

  private

  def set_tags
    @tags = Tag.all.where( :domain => @domain ).order_by( :name => :desc )

  end
  
end