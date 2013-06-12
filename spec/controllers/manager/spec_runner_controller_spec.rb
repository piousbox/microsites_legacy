require 'spec_helper'
describe Manager::SpecRunnerController do
  before :each do
    ;
  end

  describe 'GET them' do
    it 'should GET all' do
      get :all
      response.should be_success
      response.should render_template('manager/spec_runner/all')
    end

    it 'should GET :which' do
      get :which, :which => 'sites'
      response.should render_template('manager/spec_runner/which')
      # assigns(:which).should eql 'sites' # this is unnecessary, use params[:which]
    end
  end

end
