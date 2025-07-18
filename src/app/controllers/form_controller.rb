class FormController < ApplicationController
  def index
  end

  def answer_form
    form_id = params[:form_id]
    @form = Form.includes(class_forms: { class_group: :subject }).find_by(id: form_id)

    class_group_id = params[:class_group_id]
    @class_group = ClassGroup.find_by(id: class_group_id)

    @subject = Subject.find_by(id: @class_group.subject_id)

    @template = @form.template

    @questions = @template.questions.includes(:options).map do |question|
      question.options = question.options.sort_by(&:order)
      question
    end
  end

  def submit_form
    user_id = session[:user_id]
    return head :unauthorized unless user_id

    user = User.find(user_id)

    form_id = params[:form_id]
    form = Form.find_by(id: form_id)

    answers = params[:answers]

    answered_form = AnsweredForm.create!(user: user, form: form)

    form.template.questions.each do |question|
      answer_value = answers[question.id.to_s]

      if question.options.any?
        Answer.create!(
          answered_form: answered_form,
          question: question,
          option_id: answer_value,
          justification: nil
        )
      else
        Answer.create!(
          answered_form: answered_form,
          question: question,
          option_id: nil,
          justification: answer_value
        )
      end
    end

    flash[:notice] = "Formulário enviado com sucesso!"

    redirect_to authenticated_home_path
  end
end
