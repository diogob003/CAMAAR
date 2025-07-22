require 'rails_helper'

RSpec.describe FormController, type: :controller do
  let(:user_data) { test_user_with_data }
  let(:user) { user_data[:user] }
  let(:form) { user_data[:form] }
  let(:class_group) { user_data[:class_group] }
  let(:template) { user_data[:template] }

  before { session[:user_id] = user.id }

  describe 'GET #index' do
    it 'renders index' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #answer_form' do
    it 'assigns form variables using service' do
      service_result = [ form, class_group, double(:subject), template, [ double(:question) ] ]
      expect(FormControllerService).to receive(:answer_form_vars).with(hash_including('id' => form.id.to_s)).and_return(service_result)
      get :answer_form, params: { id: form.id }
      expect(assigns(:form)).to eq(form)
      expect(assigns(:class_group)).to eq(class_group)
      expect(assigns(:template)).to eq(template)
      expect(assigns(:questions)).to eq(service_result.last)
      expect(response).to be_successful
    end
  end

  describe 'POST #submit_form' do
    it 'sets flash and redirects using service result' do
      result = { type: :notice, message: 'Submitted!' }
      expect(FormControllerService).to receive(:submit_form).with(hash_including('answers' => 'foo'), user.id).and_return(result)
      post :submit_form, params: { answers: 'foo' }
      expect(flash[:notice]).to eq('Submitted!')
      expect(response).to redirect_to(authenticated_home_path)
    end
  end

  describe 'GET #list' do
    it 'assigns @forms using presenter' do
      forms = [ form ]
      presenter = instance_double(FormListPresenter, present: forms)
      expect(FormListPresenter).to receive(:new).with(user.id).and_return(presenter)
      get :list
      expect(assigns(:forms)).to eq(forms)
      expect(response).to be_successful
      expect(response).to render_template(:list)
    end
  end

  describe 'GET #new_form' do
    it 'assigns new form variables using service' do
      service_result = [ user, [ class_group ], [ template ], [ 1 ], form ]
      expect(FormControllerService).to receive(:new_form_vars).with(user.id).and_return(service_result)
      get :new_form
      expect(assigns(:user)).to eq(user)
      expect(assigns(:class_groups)).to eq([ class_group ])
      expect(assigns(:templates)).to eq([ template ])
      expect(assigns(:subject_ids)).to eq([ 1 ])
      expect(assigns(:form)).to eq(form)
      expect(response).to be_successful
      expect(response).to render_template(:new_form)
    end
  end

  describe 'POST #send_form' do
    it 'redirects and sets flash using service result' do
      result = { path: '/some_path', alert: 'Error', notice: 'Sent' }
      expect(FormControllerService).to receive(:send_form).with(hash_including('foo' => 'bar'), user.id).and_return(result)
      post :send_form, params: { foo: 'bar' }
      expect(response).to redirect_to('/some_path')
      expect(flash[:alert]).to eq('Error')
      expect(flash[:notice]).to eq('Sent')
    end
  end

  describe 'GET #results' do
    it 'assigns @forms using presenter' do
      forms = [ form ]
      presenter = instance_double(FormListPresenter, present: forms)
      expect(FormListPresenter).to receive(:new).with(user.id).and_return(presenter)
      get :results
      expect(assigns(:forms)).to eq(forms)
      expect(response).to be_successful
      expect(response).to render_template(:results)
    end
  end

  describe 'GET #download_result' do
    it 'sends CSV data using service' do
      csv_data = { data: 'csv,data', filename: 'result.csv' }
      expect(FormControllerService).to receive(:csv_result).with(form.id.to_s).and_return(csv_data)
      expect(controller).to receive(:send_data).with('csv,data', filename: 'result.csv', type: 'text/csv') do
        controller.head :ok
      end
      get :download_result, params: { form_id: form.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects and sets flash using service result' do
      result = { path: '/destroyed', alert: 'Deleted', notice: 'Form deleted' }
      expect(FormControllerService).to receive(:destroy_form).with(hash_including('id' => form.id.to_s)).and_return(result)
      delete :destroy, params: { id: form.id }
      expect(response).to redirect_to('/destroyed')
      expect(flash[:alert]).to eq('Deleted')
      expect(flash[:notice]).to eq('Form deleted')
    end
  end
end
