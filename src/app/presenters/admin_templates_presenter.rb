class AdminTemplatesPresenter
  def initialize(user)
    @user = user
  end

  def templates
    Template.where(creator_id: @user.id)
  end
end