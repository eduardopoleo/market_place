require 'spec_helper'

describe StripeWrapper::Charge do
  let (:token) do
    Stripe::Token.create(
      :card => {
        :number => card_number,
        :exp_month => 3,
        :exp_year => 2016,
        :cvc => "314"
      },
    ).id
  end

  context 'with valid input', :vcr do
    let(:card_number) {4242424242424242}
    it 'creates a charge' do
      stripe_response = StripeWrapper::Charge.create(
        amount: 777,
        card: token)
      expect(stripe_response).to be_successful
    end
  end

  context 'with invalid input', :vcr do
    let(:card_number) {4000000000000002}
    it 'creates a charge' do
      stripe_response = StripeWrapper::Charge.create(
        amount: 777,
        card: token)
      expect(stripe_response).not_to be_successful
    end

    it 'sets the delclined card error', :vcr do
      stripe_response = StripeWrapper::Charge.create(
        amount: 777,
        card: token)
      expect(stripe_response.error_message).to eq('Your card was declined.')
    end
  end

  describe StripeWrapper::Customer do
    context 'with valid input', :vcr do
      let(:card_number) {4242424242424242}
      it 'creates a charge' do
        alice = Fabricate(:user)
        stripe_response = StripeWrapper::Customer.create(
          email: alice,
          plan: 'firecamp_regular',
          card: token)
        expect(stripe_response).to be_successful
      end
    end

    context 'with invalid input', :vcr do
      let(:card_number) {4000000000000002}
      let(:alice){Fabricate(:user)}
      let(:stripe_response) {
        stripe_response = StripeWrapper::Customer.create(
        email: alice,
        plan: 'firecamp_regular',
        card: token)
      }
      it 'does not create a customer' do
        expect(stripe_response).not_to be_successful 
      end

      it 'stores the error message' do
        expect(stripe_response.error_message).to eq('Your card was declined.')
      end
    end
  end
end
