class UsersController < ApplicationController
  before_action :require_user, only: :dashboard
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      @user.update_attribute(:admin, true)

      # @amount = 777 
      #
      # charge = Stripe::Charge.create(
      #   :card  => params[:stripeToken],
      #   :amount      => @amount,
      #   :description => "Payment for #{@user.email}",
      #   :currency    => 'usd'
      # )

      AppMailer.welcome_notification(@user).deliver
      flash[:success] = 'Welcome to Firecamp! Hope you enjoy the experience'
      session[:user_id] = @user.id
      redirect_to dashboard_user_path(@user)
    else
      render :new
    end
  end

  def dashboard
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end
end
