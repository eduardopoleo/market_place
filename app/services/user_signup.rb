class UserSignup
  attr_reader :error_message

  def initialize(user)
    @user = user
  end

  def signup(stripe_token)
    if @user.valid? 
      charge = StripeWrapper::Charge.create(
        amount: 777,
        card: stripe_token
      )
      if charge.successful? 
        @status = :success
        @user.save
        @user.update_attribute(:admin, true)
        AppMailer.welcome_notification(@user).deliver
        self
      else
        @status = :failed
        @error_message = charge.error_message
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
