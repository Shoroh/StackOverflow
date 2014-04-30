class QuestionsController < ApplicationController
  before_action :set_question, only: [:show]
  before_action :authenticate_user!, :only => [:new, :create]

  def index
    @title = "Recent Questions"
    @questions = Question.limit(50).order(created_at: :desc)
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
