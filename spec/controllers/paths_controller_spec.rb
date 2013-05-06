require 'spec_helper'

module FsBrowser
  describe PathsController do
    describe '#create' do
      before { Path.base = '/' }

      it 'is successful' do
        post :create, :id => 'root', :format => :json
        response.should be_success
      end
    end
  end
end