class ProductsController < ApplicationController
  def index
    @products = current_user.products
  end

  def new
    @product = current_user.products.new
  end

  def create
    @operation = CreateProductService.prepare(params, current_user)
    @operation.perform!
    if @operation.succeed?
      flash[:notice] = 'Product added!'
      redirect_to products_path
    else
      flash[:alert] = @operation.errors
      @product = @operation.product
      render :new
    end
  end
end
