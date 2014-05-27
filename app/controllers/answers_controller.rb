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

    if params[:attachment_ids]
      params[:attachment_ids].split(",").each do |attachment|
        @attachment = Attachment.find(attachment)
        @attachment.attachmentable_id = @answer.id
        @attachment.save
      end
    end
  end

  def edit
  end


  def update
    @answer.update(answer_params)

    if params[:attachment_ids]
      params[:attachment_ids].split(",").each do |attachment|
        @attachment = Attachment.find(attachment)
        @attachment.attachmentable_id = @answer.id
        @attachment.save
      end
    end
  end

  def destroy
    @answer.destroy
  end


  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer
    @answer ||= Answer.find(params[:id])
  end

  def set_question
    @question ||= @answer.question
  end

end
