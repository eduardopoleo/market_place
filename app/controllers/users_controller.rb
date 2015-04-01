class UsersController < ApplicationController
  before_action :require_user, only: :dashboard
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid? 
      charge = StripeWrapper::Charge.create(
        amount: 777,
        card: params[:stripeToken]
      )
      if charge.successful? 
        @user.save
        @user.update_attribute(:admin, true)
        AppMailer.welcome_notification(@user).deliver
        flash[:success] = 'Welcome to Firecamp! Hope you enjoy the experience'
        session[:user_id] = @user.id
        redirect_to dashboard_user_path(@user)
      else
        flash[:error] = charge.error_message
        render :new
      end
    else
      render :new
    end
  end

  def dashboard; end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end
end
