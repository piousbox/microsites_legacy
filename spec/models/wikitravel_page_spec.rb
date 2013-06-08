require 'spec_helper'
describe WikitravelPage do

  before :each do
    Report.all.each { |r| r.remove }

    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    @anon = FactoryGirl.create :anon
    
    WikitravelPage.all.each { |w| w.remove }
  end

  describe 'something' do
    it 'does' do
    end
  end

end
