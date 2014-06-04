class AnswersController < InheritedResources::Base
  before_action :authenticate_user!
  before_action only: [:edit, :update, :destroy] do
    check_permissions(@answer)
  end
  respond_to :js
  actions :create, :update, :destroy, :edit
  belongs_to :question


  protected

  def create_resource(object)
    object.user = current_user
    attachments
    super
  end

  def attachments
      @attachment = Attachment.assign_attachments(params[:attachment_ids], resource)
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
