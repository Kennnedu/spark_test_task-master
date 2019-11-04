require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index, :format => :json
      expect(response.status).to eq(200)
    end
  end
end