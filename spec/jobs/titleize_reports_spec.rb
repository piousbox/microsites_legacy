require 'spec_helper'
describe TitleizeReports do

  before :each do
    Report.clear
    @r1 = FactoryGirl.create :r1
  end

  describe 'do work' do
    it 'does work' do
      @r1.name.should_not eql @r1.name.titleize
      a = TitleizeReports.perform
      result = Report.find( @r1.id )
      result.name.should eql result.name.titleize
    end
  end

end
