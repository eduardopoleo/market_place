class SessionsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      flash[:success] = 'You have successfully logged in!'
      redirect_to home_path
    else
      flash[:error] = 'There is a problem with your email or password'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path
  end
end
