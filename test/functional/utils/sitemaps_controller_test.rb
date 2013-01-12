
require 'test_helper'

class Utils::SitemapsControllerTest < ActionController::TestCase

  setup do
    @request.host = 'cac.local'

    Report.clear

    Tag.clear

    User.clear
    @user = FactoryGirl.create :user
    @manager = FactoryGirl.create :manager

    @tag_cac = FactoryGirl.create :tag_cac
    @cac_1 = FactoryGirl.create :cac1

  end

  test 'pi sitemap' do
    assert false, 'todo'
  end

  test 'sedux' do
    assert false, 'todo'
  end

  test 'webdevzine' do
    assert false, 'todo'
  end

  test 'ish' do
    assert false, 'todo'
  end

  test 'qxt' do
    assert false, 'todo'
  end

  test 'cac' do
    assert false, 'todo'
  end

  test 'travel' do
    assert false, 'todo'
  end
  
end