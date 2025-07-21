# Serviço para simplificar a logica do form_controller
class FormControllerService
  def self.answer_form_vars(params)
    FormAnswerPresenter.new(params).present
  end

  def self.submit_form(params, user_id)
    FormSubmitService.call(params, user_id)
  end

  def self.new_form_vars(user_id)
    FormNewPresenter.new(user_id).present
  end

  def self.send_form(params, user_id)
    FormSendService.call(params, user_id)
  end

  def self.csv_result(form_id)
    FormDownloadService.call(form_id)
  end

  def self.destroy_form(params)
    FormDestroyService.call(params)
  end
end