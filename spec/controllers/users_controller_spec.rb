require 'spec_helper'

describe UsersController do
  describe 'Get NEW' do
    it 'renders the new registration form' do
      get :new
      expect(response).to render_template :new
    end

    it 'sets the new users variables' do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'Post create' do
    context 'with valid input' do
      before {post :create, user: Fabricate.attributes_for(:user)}

      it 'redirects to the home page' do
        expect(response).to redirect_to home_path
      end

      it 'creates a todo' do
        expect(User.count).to eq(1)
      end
      
      it 'sets a success flash message' do
        expect(flash[:success]).to be_present
      end
      
      it 'sets admin to equal true' do
        expect(User.first.admin).to eq(true)
      end

      it 'sets the session user_id' do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it 'send a notification email when the user signs is' do
        expect(ActionMailer::Base.deliveries.last.to).to eq([User.first.email])
        ActionMailer::Base.deliveries.clear
      end
    end

    context 'with invalid input' do
      it 'does not create a todo with missing inputs' do
        post :create, user: {full_name:"something"}
        expect(User.count).to eq(0)
      end

      it 'does not create a todo repeated email' do
        joe = Fabricate(:user, email: "joe@example.com")
        post :create, user: Fabricate.attributes_for(:user, email: "joe@example.com")
        expect(User.count).to eq(1)
      end

      it 'renders the new template' do
        post :create, user: {full_name:"something"}
        expect(response).to render_template :new
      end

      it 'renders the @users variables with validatation errors' do
        post :create, user: {full_name:"something"}
        expect(assigns(:user)).to be_present
      end
    end
  end
end
