class AnswersController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, :flash => {:info => "Answer was successfully added!" }}
        format.js
      else
        @question = Question.find(params[:question_id])
        format.html { render 'questions/show' }
        format.js
      end
    end
  end


  private

  def answer_params
    params.require(:answer).permit(:body)
  end

end
