require "csv"

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

    @template.questions = @template.questions.sort_by(&:order)

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

  def list
    user_id = session[:user_id]
    return head :unauthorized unless user_id

    user = User.find(user_id)

    @forms = Form
       .where(publisher_id: user.id)
       .includes(:template, class_groups: :subject)

    @forms.each do |form|
      form.class_groups.each do |class_group|
        class_group.subject = Subject.find(class_group.subject_id)
        subject_name = class_group.subject.name
        subject_code = class_group.subject.code
      end
    end
  end

  def new_form
    user_id = session[:user_id]
    return head :unauthorized unless user_id
    @user = User.find(user_id)

    class_group_ids = []
    class_group_ids += @user.class_professors.pluck(:class_group_id) if @user.respond_to?(:class_professors)
    class_group_ids.uniq!

    @class_groups = ClassGroup.where(id: class_group_ids)
    @templates = Template.where(creator_id: @user.id)

    @subject_ids = @class_groups.map(&:subject_id)
    @form = Form.new
  end

  def send_form
    user_id = session[:user_id]
    return head :unauthorized unless user_id

    class_group_id = params[:class_group_id]
    template_id = params[:template_id]

    @form = Form.new(
      publisher_id: user_id,
      template_id: template_id,
    )

    @class_form = ClassForm.new(
      class_group_id: class_group_id,
      form: @form
    )

    if @form.save && @class_form.save
      redirect_to list_forms_path, notice: "Form created successfully."
    else
      redirect_to new_form_path, alert: "Error creating form"
    end
  end

  def results # same code as 'list'
    user_id = session[:user_id]
    return head :unauthorized unless user_id

    user = User.find(user_id)

    @forms = Form
               .where(publisher_id: user.id)
               .includes(:template, class_groups: :subject)

    @forms.each do |form|
      form.class_groups.each do |class_group|
        class_group.subject = Subject.find(class_group.subject_id)
        subject_name = class_group.subject.name
        subject_code = class_group.subject.code
      end
    end
  end

  def download_result
    form = Form.includes(:answered_forms, template: :questions).find(params[:form_id])
    questions = form.template.questions.order(:order)
    answered_forms = form.answered_forms.includes(:answers)

    csv_data = CSV.generate(headers: true) do |csv|
      csv << questions.map(&:title)

      answered_forms.each do |answered_form|
        row = questions.map do |question|
          answer = answered_form.answers.find { |a| a.question_id == question.id }
          if question.options.any?
            answer&.option&.description
          else
            answer&.justification
          end
        end
        csv << row
      end
    end

    send_data csv_data,
              filename: "form_#{form.id}_results.csv",
              type: "text/csv"
  end

  def destroy
    form = Form.find(params[:id])
    class_form = ClassForm.find(params[:class_form_id])

    if form.answered_forms.exists?
      redirect_to list_forms_path, alert: "Cannot delete: form has associated answers."
    else
      class_form.destroy
      form.destroy
      redirect_to list_forms_path, notice: "Form deleted successfully."
    end
  end

end
