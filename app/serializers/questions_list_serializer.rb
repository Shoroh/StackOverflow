class QuestionsListSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at, :body, :answers_count

  def body
    # object.body.truncate(100)
    object.body
  end

  def answers_count
    object.answers.count
  end

end
