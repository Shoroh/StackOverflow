class Answer < ActiveRecord::Base
  has_many :comments, as: :commentable
  belongs_to :user, counter_cache: :answers_count
  belongs_to :question, counter_cache: :answers_count


  validates :body, :presence => true
  validates :body, length: 3..6000

  # Answers could have flags:
  enum status: {
      active:       0,
      pending:      1,
      deleted:      2
  }

  scope :recent, -> { order(created_at: :asc) }

end
