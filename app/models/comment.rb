# User can add comments to any questions and answers.
class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true, length: 3...255
end
