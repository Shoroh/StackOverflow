class Vote < ActiveRecord::Base

  belongs_to :votable, :polymorphic => true
  belongs_to :user

  validates_presence_of :votable_id
  validates_presence_of :votable_type
  validates_presence_of :user
  validates_presence_of :value

  enum value: { abstain: 0, like: 1, unlike: 2 }


end
