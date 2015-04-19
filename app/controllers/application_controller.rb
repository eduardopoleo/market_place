class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :loggedin?, :current_cart

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def loggedin?
    !!current_user
  end

  def require_user
    if !loggedin?
      redirect_to root_path
    end
  end

  def create_new_cart
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def current_cart
    if session[:cart_id]
      begin
        Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        create_new_cart
      end
    else
      create_new_cart 
    end
  end
end
