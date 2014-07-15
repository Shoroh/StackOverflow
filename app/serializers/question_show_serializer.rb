class QuestionShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :answers_count
  has_many :answers
  has_many :comments

  def answers_count
    object.answers.count
  end

end
