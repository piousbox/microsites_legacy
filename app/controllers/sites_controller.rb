class SitesController < ApplicationController
  skip_authorization_check
  # caches_page :features, :show
  before_filter :redirect_mobile_user, :only => [ :show ]

  def features
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse # .page( params[:features_page] )
    render :layout => @layout
  end

  def show
    # site is set in application_controller
    # feature cities should be made as sticky features
    # feature tags, as well
    # increase the number of features in increments of 4 as necessary (8 looks good)

    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse
    @newsitems = @site.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] ).per(@site.n_newsitems)
    
    @feature_tags = Tag.where( :parent_tag => nil, :site => @site ).order_by( :name => :desc )

    respond_to do |format|
      format.html do
        render :layout => 'application_mini'
      end
      format.mobile do
        render :layout => 'organizer'
      end
      format.json do
        render :json => { :features => @features, :newsitems => @newsitems }
      end
    end
  end

end
