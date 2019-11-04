require 'csv'

class ProductsController < ApplicationController
  def index
    @product_repository = ProductRepository.new(
        Spree::Product.includes(:stock_items, taxons: [:taxonomy], master: [:default_price])
      ).paginate(params[:limit], params[:offset])

    respond_to do |format|
      format.csv { send_data @product_repository.to_csv }
    end
  end
end