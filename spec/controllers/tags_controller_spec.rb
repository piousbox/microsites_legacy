
require 'spec_helper'

describe TagsController do

  before :each do
    Tag.all.each { |c| c.remove }

    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user
    @anon = FactoryGirl.create :anon
    sign_in :user, @user
    
  end

end
