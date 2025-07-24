# Controller responsavel ppor tudo que envolve formulários
# listagem, criacao, responder e etc

class FormController < ApplicationController
  def index; end

  def answer_form
    @form, @class_group, @subject, @template, @questions =
      FormControllerService.answer_form_vars(params)
  end

  def submit_form
    result = FormControllerService.submit_form(params, session[:user_id])
    flash[result[:type]] = result[:message]
    redirect_to authenticated_home_path
  end

  def list
    @forms = FormListPresenter.new(session[:user_id]).present
  end

  def new_form
    @user, @class_groups, @templates, @subject_ids, @form =
      FormControllerService.new_form_vars(session[:user_id])
  end

  def send_form
    result = FormControllerService.send_form(params, session[:user_id])
    redirect_to result[:path], alert: result[:alert], notice: result[:notice]
  end

  def results
    @forms = FormListPresenter.new(session[:user_id]).present
  end

  def download_result
    csv_data = FormControllerService.csv_result(params[:form_id])
    send_data csv_data[:data], filename: csv_data[:filename], type: "text/csv"
  end

  def destroy
    result = FormControllerService.destroy_form(params)
    redirect_to result[:path], alert: result[:alert], notice: result[:notice]
  end
end
