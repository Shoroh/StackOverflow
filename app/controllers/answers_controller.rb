class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, except: :update
  before_action :set_answer, only: [:edit, :update, :destroy]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, :flash => {:info => "Answer was successfully added!" }}
        format.js
      else
        @question = Question.find(params[:question_id])
        format.html { render 'questions/show' }
        format.js { render action: 'new' }
      end
    end
  end

  def edit
    unless @answer.user == current_user
      redirect_to @question, :flash => {:warning => "You don't have permissions to edit this answer!" }
    end
  end


  def update
    @question = @answer.question
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @question, :flash => {:info => "Answer was successfully updated!"} }
        format.js
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to @question, :flash => {:info => "Answer was successfully deleted!"} }
      format.js
    end
  end


  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

end
