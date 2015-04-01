class UsersController < ApplicationController
  before_action :require_user, only: :dashboard
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    user_signup = UserSignup.new(@user).signup(params[:stripeToken])

    if user_signup.successful?
      flash[:success] = 'Welcome to Firecamp! Hope you enjoy the experience'
      session[:user_id] = @user.id
      redirect_to dashboard_user_path(@user)
    else
      flash[:error] = user_signup.error_message
      render :new
    end
  end

  def dashboard; end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end
end
