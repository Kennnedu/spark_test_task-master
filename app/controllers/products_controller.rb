class ProductsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: { msg: 'Test' } }
    end
  end
end