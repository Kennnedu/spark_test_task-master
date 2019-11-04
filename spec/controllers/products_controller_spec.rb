require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  before do
    @max_products_count = 16
    @default_limit = 5
  end

  describe 'GET index csv' do
    before { get :index, :format => :csv }

    it { expect(response.status).to eq(200) }

    it { expect(response.content_type).to eq('application/octet-stream') }

    it do
      expect(response.body.split("\n").first).to eq("name;description;price;availability_date;slug;stock_total;category")
    end

    it { expect(response.body.split("\n").size).to eq(@default_limit + 1) } # with header
  end

  describe 'GET index csv pagination' do
    it "has max limit #{@max_products_count}" do
      get :index, params: { limit: @max_products_count }, format: :csv
      expect(response.body.split("\n").size).to eq(@max_products_count + 1) # with header
    end

    it "has max limit #{@max_products_count} and offset one less max limit" do
      get :index, params: { limit: @max_products_count, offset: (@max_products_count - 1) }, format: :csv
      expect(response.body.split("\n").size).to eq(2) # with header
    end

    it "has offset one less max limit" do
      get :index, params: { offset: (@max_products_count - 1) }, format: :csv
      expect(response.body.split("\n").size).to eq(2) # with header
    end
  end
end