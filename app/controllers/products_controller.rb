class ProductsController < ApplicationController
  def index
    @products = current_user.products
  end

  def new
    @product = current_user.products.new
  end
end
