class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @order_item = OrderItem.new
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "Your Product was updated"
      redirect_to products_path
    else
      render :edit
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Your Product was created"
      redirect_to products_path
    else
      render :new
    end
  end

  private 

  def product_params
    params.require(:product).permit(:name, :description, :price, :cover)
  end
end
