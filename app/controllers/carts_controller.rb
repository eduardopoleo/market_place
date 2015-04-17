class CartsController < ApplicationController
  def show_current_cart 
    @cart = current_cart
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def index
    @carts = Cart.where(active: false)
  end
end
