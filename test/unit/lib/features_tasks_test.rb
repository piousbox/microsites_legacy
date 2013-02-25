
require 'test_helper'
require 'features_tasks'

class FeaturesTasksTest < ActiveSupport::TestCase

  setup do
    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site
  end

  test 'titleize' do
    assert_equal 0, @site.features.length
    f = Feature.new :name => 'blah blah'
    @site.features << f
    @site.save
    assert_equal 1, @site.features.length
    
    FeaturesTasks.titleize

    new_feature = Site.first.features[0]
    assert_equal 'Blah Blah', new_feature.name

  end

end
