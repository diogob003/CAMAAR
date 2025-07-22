require 'rails_helper'

RSpec.describe AdminTemplatesController, type: :controller do
  let(:user_data) { test_user_with_data }
  let(:user) { user_data[:user] }
  let(:template) { user_data[:template] }
  let(:valid_params) do
    {
      template: {
        title: 'New Template',
        description: 'Description',
        questions_attributes: [
          {
            title: 'Q1',
            answer_type: 'text',
            order: 1,
            options_attributes: [
              { description: 'Option 1', order: 1 }
            ]
          }
        ]
      }
    }
  end

  let(:invalid_params) do
    {
      template: {
        title: '',
        description: 'Description'
      }
    }
  end

  describe 'GET #index' do
    it 'renders index' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #list' do
    context 'when not logged in' do
      it 'returns unauthorized' do
        get :list
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      before { session[:user_id] = user.id }

      it 'assigns @templates' do
        get :list
        expect(assigns(:templates)).to eq(Template.where(creator_id: user.id))
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new template' do
      get :new
      expect(assigns(:template)).to be_a_new(Template)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'when not logged in' do
      it 'returns unauthorized' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      before { session[:user_id] = user.id }

      context 'with valid params' do
        it 'creates template and redirects with notice' do
          expect {
            post :create, params: valid_params
          }.to change(Template, :count).by(1)
          expect(response).to redirect_to(admin_templates_list_path)
          expect(flash[:notice]).to eq('Template created successfully.')
        end
      end

      context 'with blank title' do
        it 'redirects with alert' do
          post :create, params: invalid_params
          expect(response).to redirect_to(admin_templates_list_path)
          expect(flash[:alert]).to eq("Template name can't be blank.")
        end
      end

      context 'with other invalid params' do
        it 'renders new with unprocessable_entity' do
          allow_any_instance_of(Template).to receive(:save).and_return(false)
          post :create, params: valid_params
          expect(response).to render_template(:new)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'when not logged in' do
      it 'returns unauthorized' do
        get :edit, params: { id: template.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      before { session[:user_id] = user.id }

      context 'when authorized' do
        it 'assigns @template and renders edit' do
          get :edit, params: { id: template.id }
          expect(assigns(:template)).to eq(template)
          expect(response).to render_template(:edit)
        end
      end

      context 'when not authorized' do
        let(:other_user) { User.create!(email: 'other@example.com', name: 'Other', password: 'other123', registration: 'O123', role: 'professor') }
        let(:other_template) { Template.create!(title: 'Other', description: 'Other', creator_id: other_user.id) }

        it 'redirects with alert' do
          get :edit, params: { id: other_template.id }
          expect(response).to redirect_to(admin_templates_list_path)
          expect(flash[:alert]).to eq('You are not authorized to edit this template.')
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'when not logged in' do
      it 'returns unauthorized' do
        patch :update, params: { id: template.id }.merge(valid_params)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      before { session[:user_id] = user.id }

      context 'when authorized' do
        it 'updates and redirects with notice' do
          patch :update, params: { id: template.id }.merge(valid_params)
          expect(response).to redirect_to(admin_templates_list_path)
          expect(flash[:notice]).to eq('Template updated successfully.')
        end

        it 'renders edit with unprocessable_entity on failure' do
          allow_any_instance_of(Template).to receive(:update).and_return(false)
          patch :update, params: { id: template.id }.merge(valid_params)
          expect(response).to render_template(:edit)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when not authorized' do
        let(:other_user) { User.create!(email: 'other@example.com', name: 'Other', password: 'other123', registration: 'O123', role: 'professor') }
        let(:other_template) { Template.create!(title: 'Other', description: 'Other', creator_id: other_user.id) }

        it 'redirects with alert' do
          patch :update, params: { id: other_template.id }.merge(valid_params)
          expect(response).to redirect_to(admin_templates_list_path)
          expect(flash[:alert]).to eq('You are not authorized to edit this template.')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when not logged in' do
      it 'returns unauthorized' do
        delete :destroy, params: { id: template.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logged in' do
      before { session[:user_id] = user.id }

      context 'when authorized' do
        it 'destroys template and redirects with notice' do
          new_template = Template.create!(title: 'ToDelete', description: 'Desc', creator_id: user.id)
          delete :destroy, params: { id: new_template.id }
          expect(response).to redirect_to(admin_templates_list_path)
          expect(flash[:notice]).to eq('Template deleted successfully.')
        end

        it 'does not destroy if associated forms exist, redirects with alert' do
          delete :destroy, params: { id: template.id }
          expect(response).to redirect_to(admin_templates_list_path)
          expect(flash[:alert]).to eq('Cannot delete: template has associated forms.')
        end
      end

      context 'when not authorized' do
        let(:other_user) { User.create!(email: 'other@example.com', name: 'Other', password: 'other123', registration: 'O123', role: 'professor') }
        let(:other_template) { Template.create!(title: 'Other', description: 'Other', creator_id: other_user.id) }

        it 'redirects with alert' do
          delete :destroy, params: { id: other_template.id }
          expect(response).to redirect_to(admin_templates_list_path)
          expect(flash[:alert]).to eq('You are not authorized to edit this template.')
        end
      end
    end
  end
end
