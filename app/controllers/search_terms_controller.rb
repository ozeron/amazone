class SearchTermsController < ApplicationController

  def new
    @product = current_user.products.find_by(id: params[:product_id])
  end

  def create
    @operation = CreateSearchTermsService.prepare(params, current_user)
    @operation.perform!
    if @operation.succeed?
      flash[:notice] = 'Search Terms added!'
      redirect_to products_path
    else
      flash[:alert] = @operation.errors
      @product = @operation.product
      render :new
    end
  end
end
