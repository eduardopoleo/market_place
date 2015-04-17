class OrderItemsController < ApplicationController
  def create
    cart = current_cart
    @product = Product.find(params[:product_id])
    @order_item = cart.order_items.build(
      product: @product,
      quantity: params[:order_item][:quantity],
      unit_price: @product.price) 

    if @order_item.save
      cart.update_cart
      redirect_to show_current_cart_path
    else
      render 'products/show'
    end
  end

  private

  def product_items_params
    params.require(:order_item).permit(:quantity)
  end
end
