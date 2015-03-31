class WelcomeController < ApplicationController
  def landing_page
    if loggedin?
      redirect_to dashboard_user_path(current_user)
    end
  end
end
