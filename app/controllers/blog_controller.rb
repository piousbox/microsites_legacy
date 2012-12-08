

class BlogController < ApplicationController
  
  def home
    @reports = Report.fresh.public.where( :domain => @domain ).sort( :created_at => :desc ) # .page( params[:reports_page] )
    render :layout => 'blog'
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

  def show_report
    @report = Report.where( :name_seo => params[:name_seo] ).first
    render 'show', :layout => 'blog'
  end

end