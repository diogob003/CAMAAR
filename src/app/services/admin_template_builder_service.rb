# Serviço responsavel por criar templates
class AdminTemplateBuilderService
  def initialize(user = nil, params = nil)
    @user = user
    @params = params
  end

  def build_new
    template = Template.new
    template.questions.build
    template
  end

  def build_with_creator
    template = Template.new(@params)
    template.creator_id = @user.id
    template
  end
end