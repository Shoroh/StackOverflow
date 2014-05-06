class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  # Stats. Writes log by parameters: #show, ip_address
  # @example In View — @question.impressionist_count
  # @note TODO — add :ip_address to unique: in production mode
  impressionist :actions=>[:show], :unique => [:impressionable_id, :session_hash, :impressionable_type ]

  def index
    @title = "Recent Questions"
    @questions = Question.recent.page(params[:page])
  end

  def featured
    @title = "Featured Questions"
    @questions = Question.featured.page(params[:page])
    render 'questions/index'
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, :flash => {:info => "Question was successfully created!" }}
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, :flash => {:info => "Question was successfully updated!"} }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_path, :flash => {:info => "Question was successfully deleted!"} }
      format.json { head :no_content }
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
