class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.user = current_user
    if @comment.save!
      respond_to do |format|
        format.html {redirect_to @question}
        format.js
      end
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_commentable
    @commentable = params[:commentable_type].classify.constantize.find(params[:commentable_id])
  end

end
