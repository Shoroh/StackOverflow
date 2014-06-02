# User can add comments to any questions and answers.
class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true, length: 3...255

  private

  def self.create(comment_params, commentable, current_user)
    comment = self.new(body: comment_params[:body], commentable: commentable, user: current_user)
    comment.save
    return comment
  end

end
