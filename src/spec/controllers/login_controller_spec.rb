require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  let(:user) { test_user }

  describe 'GET #index' do
    it 'renders the login page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #login' do
    context 'with valid credentials (email)' do
      it 'logs in and redirects to authenticated home' do
        post :login, params: { email_enrollment: user.email, password: 'maria1122' }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(authenticated_home_path)
        expect(flash[:notice]).to eq('Logged in!')
      end
    end

    context 'with valid credentials (registration)' do
      it 'logs in and redirects to authenticated home' do
        post :login, params: { email_enrollment: user.registration, password: 'maria1122' }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(authenticated_home_path)
        expect(flash[:notice]).to eq('Logged in!')
      end
    end

    context 'with invalid credentials' do
      it 'renders index with alert and unprocessable_entity status' do
        post :login, params: { email_enrollment: user.email, password: 'wrongpass' }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash.now[:alert]).to eq('Senha ou email inválido')
      end

      it 'renders index if user not found' do
        post :login, params: { email_enrollment: 'notfound@example.com', password: 'any' }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:index)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash.now[:alert]).to eq('Senha ou email inválido')
      end
    end
  end

  describe 'DELETE #logout' do
    before { session[:user_id] = user.id }

    it 'clears session and redirects to root' do
      delete :logout
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end
