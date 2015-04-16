class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @order_item = OrderItem.new
    @product = Product.find(params[:id])
  end
end
