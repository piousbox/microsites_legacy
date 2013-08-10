
class WelcomeController < ApplicationController
  skip_authorization_check
  before_filter :load_features

  # caches_page :homepage, :features, :newsitems
  
  def home
    if params[:site_id]
      @site = Site.find params[:site_id]
    end

    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse
    @newsitems = @site.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] ).per(@site.n_newsitems)
    
    @feature_tags = Tag.where( :parent_tag => nil, :site => @site ).order_by( :name => :desc )

    respond_to do |format|
      format.html do
        render
      end
      format.json do
        @newsitems.each do |n|
          if !n.report.blank?
            n['name'] = n.report.name
            n['url'] = url_for( :controller => 'reports', :action => 'show', :name_seo => n.report.name_seo )
          end
        end
        render :json => { :features => @features, :newsitems => @newsitems }
      end
    end
  end


  def features
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse # .page( params[:features_page] )
    render :layout => @layout
  end

  def newsitems
    ;
  end

end
