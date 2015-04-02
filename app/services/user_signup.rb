class UserSignup
  attr_reader :error_message

  def initialize(user)
    @user = user
  end

  def signup(stripe_token)
    if @user.valid? 
      customer = StripeWrapper::Customer.create(
        plan: "firecamp_regular",
        card: stripe_token,
        email: @user.email
      )
      if customer.successful? 
        @status = :success
        @user.save
        @user.update_attribute(:admin, true)
        AppMailer.welcome_notification(@user).deliver
        self
      else
        @status = :failed
        @error_message = customer.error_message
        self
      end
    else
      @status = :failed
      @error_message = "Your user information is not valid. Please check the errors below"
      self
    end
  end

  def successful?
    @status == :success
  end
end
