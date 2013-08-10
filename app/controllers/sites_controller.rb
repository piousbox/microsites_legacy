
class SitesController < ApplicationController

  def show
    authorize! :show, Site.new
  end

  def features
    authorize! :features, Site.new
  end

  def newsitems
    authorize! :newsitems, Site.new
  end

end
