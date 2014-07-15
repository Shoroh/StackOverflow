class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with collection.limit(params[:limit] || 10).offset(params[:offset] || 0), meta: { timestamp: collection.recent.first.created_at }, each_serializer: QuestionsListSerializer, root: 'questions'
  end

  def show
    respond_with resource, serializer: QuestionShowSerializer, root: 'question'
  end

  protected

  def create_resource(object)
    object.user = current_resource_owner
    super
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id)
  end

end