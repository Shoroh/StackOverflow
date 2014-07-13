class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with collection, meta: { timestamp: collection.recent.first.created_at }
  end

end