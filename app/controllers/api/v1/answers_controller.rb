class Api::V1::AnswersController < Api::V1::BaseController
  respond_to :json
  belongs_to :question, parent_class: Question


  def index
    respond_with collection, each_serializer: AnswersListSerializer, root: 'answers'
  end

  def show
    respond_with resource, serializer: AnswerShowSerializer, root: 'answer'
  end

end