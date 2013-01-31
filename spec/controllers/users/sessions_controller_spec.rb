
require 'spec_helper'
describe Users::SessionsController do

  before :each do
    User.all.each { |u| u.remove }
    Day.all.each { |d| d.remove }
    Addressbookitem.all.each { |d| d.remove }

    @user = FactoryGirl.create :user

    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

end
