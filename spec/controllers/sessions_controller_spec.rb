require 'spec_helper'

describe SessionsController do
  describe "Get new" do
    it 'renders the login template' do
      get :new 
      expect(response).to render_template :new
    end
  end

  describe 'Post create' do
    context 'with valid input' do
      let(:joe) {Fabricate(:user)}
      before {post :create, email: joe.email, password: joe.password}

      it 'redirects to the home path' do
        expect(response).to redirect_to dashboard_user_path(joe)
      end

      it 'sets the session id to the user id' do
        expect(session[:user_id]).to eq(joe.id)
      end

      it 'sets a success flash message' do
        expect(flash[:success]).to be_present 
      end
    end

    context 'with invalid input' do
      before{post :create, email: 'joe@gmail.com', password: 'password'}
       
      it 'redirects to the new action ' do
        expect(response).to redirect_to login_path
      end

      it 'does not set the user id into the session' do
        expect(session[:user_id]).to be_nil
      end

      it 'sets a generic flash message' do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'Get destroy' do
    let(:joe) {Fabricate(:user)}
    before do
      session[:user_id] = joe.id
      get :destroy
    end

    it 'redirects to the home path' do
      expect(response).to redirect_to root_path
    end

    it 'redirects to the home path' do
      expect(session[:user_id]).to be_nil
    end
  end
end
