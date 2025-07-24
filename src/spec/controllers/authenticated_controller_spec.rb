require 'rails_helper'

RSpec.describe AuthenticatedController, type: :controller do
  describe 'GET #home' do
    context 'when not logged in' do
      it 'redirects to login when not logged in' do
        get :home
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(login_path)
      end
    end

    context 'when logged in' do
      let(:user) { test_user }
      let(:class_group) { test_class_group(user) }
      let!(:form) { test_form(class_group, user) }

      before { session[:user_id] = user.id }

      it 'assigns @forms_data' do
        get :home
        expect(assigns(:forms_data)).to be_present
      end
    end
  end

  describe 'GET #admin' do
    context 'when not logged in' do
      it 'redirects to login when not logged in' do
        get :admin
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(login_path)
      end
    end

    context 'when logged in' do
      let(:user) { test_user_with_data[:user] }
      before { session[:user_id] = user.id }

      it 'assigns @classrooms, @templates, @sent_forms' do
        get :admin
        expect(assigns(:classrooms)).to be_present
        expect(assigns(:templates)).to be_present
        expect(assigns(:sent_forms)).to be_present
      end
    end
  end
end
