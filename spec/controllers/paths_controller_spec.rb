require 'spec_helper'

module FileBrowser
  describe PathsController do
    describe '#show' do
      it 'is successful' do
        get :show, :id => 'root', :format => :json
        response.should be_success
      end
    end
  end
end