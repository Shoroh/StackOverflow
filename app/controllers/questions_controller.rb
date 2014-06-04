class QuestionsController < InheritedResources::Base
  respond_to :js, expect: :destroy
  custom_actions collection: [:featured, :popular, :unanswered]
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :title, except: [:create, :update, :destroy]
  before_action :sort, only: [:popular, :featured, :unanswered]
  before_action only: [:edit, :update, :destroy] do
    check_permissions(@question)
  end
  before_action :build_answer, only: :show

  # Stats. Writes log by parameters: #show, ip_address
  # @example In View — @question.impressionist_count
  # @note TODO — add :ip_address to unique: in production mode
  impressionist :actions=>[:show], :unique => [:impressionable_id, :session_hash, :impressionable_type ]

  protected

  def create_resource(object)
    object.user = current_user
    attachments
    super
  end

  def build_answer
    @answer = Answer.new
  end

  def collection
    if params[:tag]
      @questions ||= end_of_association_chain.tagged_with(params[:tag]).page(params[:page])
    else
      @questions ||= end_of_association_chain.send(action_scope).page(params[:page])
    end
  end

  def attachments
    @attachment = Attachment.assign_attachments(params[:attachment_ids], resource)
  end

  def title
    @title ||= if params[:action] == 'show'
               resource.title
             else
               (params[:tag] || action_scope.capitalize)
             end
  end

  def action_scope
    @action_scope = params[:action] == 'index' ? 'recent' : params[:action]
  end

  def sort
    render 'questions/index'
  end

  def question_params
    params.require(:question).permit(:title, :body, :tag_list)
  end

end
