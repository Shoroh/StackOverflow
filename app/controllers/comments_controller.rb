class CommentsController < ApplicationController
  before_action :set_commentable, only: :create
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html {redirect_to @commentable.try(:question) || @commentable}
        format.js
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    unless @comment.user == current_user
      redirect_to @comment.commentable.try(:question) || @comment.commentable, :flash => {:warning => "You don't have permissions to edit this comment!" }
    end
  end

  def update
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.js { render :update }
      else
        format.js { render action: 'edit' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
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
