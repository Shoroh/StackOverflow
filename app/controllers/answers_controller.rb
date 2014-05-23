class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_question, except: :create
  before_action only: [:edit, :update, :destroy] do
    check_permissions(@answer)
  end
  respond_to :js

  def create
    @question ||= Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def edit
  end


  def update
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
  end


  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def set_answer
    @answer ||= Answer.find(params[:id])
  end

  def set_question
    @question ||= @answer.question
  end

end
