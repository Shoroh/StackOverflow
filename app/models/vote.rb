class Vote < ActiveRecord::Base

  belongs_to :votable, :polymorphic => true
  belongs_to :user

  validates :value, :user, :votable_type, :votable_id, presence: true

  enum value: { abstain: 0, like: 1, unlike: 2 }

  scope :questions, -> { where(votable_type: 'Question') }
  scope :answers, -> { where(votable_type: 'Answer') }

end
