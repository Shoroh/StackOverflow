class CommentsController < ApplicationController
  before_action :initialize_commentable_object, only: :create
  before_action :initialize_question
  before_action :authenticate_user!, :only => [:create]


  def create
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable_object
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @question, notice: 'Комментарий был успешно добавлен!' }
        format.js
      else
        format.html { redirect_to @question, alert: 'Комментарий не был добавлен!' }
        format.js { render "shared/error", locals:{object: @comment} }
      end
    end
  end


  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def initialize_question
    @question = Question.find params[:question_id]
  end

  def initialize_commentable_object
    case
      when params[:answer_id].present?
        @commentable_object = Answer.find(params[:answer_id])
      when params[:question_id].present?
        @commentable_object = Question.find(params[:question_id])
      else
    end
  end

end
