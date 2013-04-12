class SitesController < ApplicationController
  skip_authorization_check
  caches_page :features

  def features
    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse # .page( params[:features_page] )
    render :layout => @layout
  end

  def show
    # site is set in application_controller
    # feature cities should be made as sticky features
    # feature tags, as well
    # increase the number of features in increments of 4 as necessary (8 looks good)

    @features = @site.features.all.sort_by{ |f| [ f.weight, f.created_at ] }.reverse # [0...4]
    @newsitems = @site.newsitems.all.order_by( :created_at => :descr ).page( params[:newsitems_page] ).per(@site.n_newsitems)
    
    # for the homepage tags thingie, can be abstracted into a standard feature
    @feature_tags = Tag.where( :is_trash => false, :parent_tag => nil ).order_by( :name => :desc )
    
    layout = ( 'organizer' == @layout ) ? @layout : 'application_mini'
    render :layout => layout
  end

  private

  after_filter(:only => :show) do |controller|
    controller.class.cache_page(controller.response.body, controller.request.path, 'com.html', nil )
  end

end
