require 'spec_helper'

describe UserSignup do
  describe '#signup' do
    context "with valid user information and valid credit card" do
      let(:user_signup) {UserSignup.new(Fabricate.build(:user))}
      before do
        customer = double('customer')
        customer.stub(:successful?).and_return(true)
        StripeWrapper::Customer.stub(:create).and_return(customer)
        user_signup.signup('some_token')
      end

      it 'makes user signup to be successful' do
        expect(user_signup).to be_successful
      end

      it 'creates a user' do
        expect(User.count).to eq(1)
      end

      it 'sets admin to equal true' do
        expect(User.first.admin).to eq(true)
      end

      it 'send a notification email when the user signs is' do
        expect(ActionMailer::Base.deliveries.last.to).to eq([User.first.email])
        ActionMailer::Base.deliveries.clear
      end
    end

    context 'with invalid user information input' do
      let(:user_signup) {UserSignup.new(Fabricate.build(:user, email: ''))}
      before do
        user_signup.signup('some_token')
      end

      it 'makes the user signup unsuccessful' do
        expect(user_signup).not_to be_successful
      end

      it 'does not create the user' do
        expect(User.count).to eq(0)
      end

      it 'sets a general error message' do
        expect(user_signup.error_message).to eq("Your user information is not valid. Please check the errors below")
      end
    end 

    context 'with valid users info but invalid payment information' do
      let(:user_signup) {UserSignup.new(Fabricate.build(:user))}
      before do
        customer = double('customer', successful?: false, error_message: "Your card was declined")
        StripeWrapper::Customer.stub(:create).and_return(customer)
        user_signup.signup('some_token')
      end
      
      it 'makes the user signup unsuccessful' do
        expect(user_signup).not_to be_successful
      end

      it 'does not create the user' do
        expect(User.count).to eq(0)
      end

      it 'sets the user sign up error message to your card is not valid' do
        expect(user_signup.error_message).to eq("Your card was declined")
      end
    end
  end
end
