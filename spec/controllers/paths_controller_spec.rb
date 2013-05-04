require 'spec_helper'

module FileBrowser
  describe PathsController do
    describe '#create' do
      before { Path.stub(:get_entries => [], :validate => true) }
      it 'is successful' do
        post :create, :id => 'root', :format => :json
        response.should be_success
      end
    end
  end
end