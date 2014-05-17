class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: :create
  before_action :set_comment, except: :create
  before_action except: :create do
    check_permissions(@comment)
  end
  respond_to :js

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.user = current_user
    @comment.save
    #respond_with @comment
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      render :update
    else
      render action: 'edit'
    end
  end

  def destroy
    @comment.destroy
    respond_with @comment
  end

  private

  def set_comment
    @comment ||= Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_commentable
    @commentable = params[:commentable_type].classify.constantize.find(params[:commentable_id])
  end

end
