class QuestionsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :sort, only: [:popular, :featured, :index, :unanswered]
  before_action :title, only: [:show, :edit]
  before_action only: [:edit, :update, :destroy] do
    check_permissions(@question)
  end

  # Stats. Writes log by parameters: #show, ip_address
  # @example In View — @question.impressionist_count
  # @note TODO — add :ip_address to unique: in production mode
  impressionist :actions=>[:show], :unique => [:impressionable_id, :session_hash, :impressionable_type ]


  def index
  end

  def featured
  end

  def popular
  end

  def unanswered
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    respond_to do |format|
      if @question.save
        # TODO Написать спеки в модели!
        attachments
        format.html { redirect_to @question, :flash => {:info => "Question was successfully created!" }}
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        attachments
        format.html { redirect_to @question, flash: {info: "Question was successfully created!"} }
        format.js
      else
        format.html { render action: 'edit' }
        format.js
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_path, flash: {info: "Question was successfully deleted!"} }
    end
  end

  private

  def attachments
    @attachment = Attachment.create_attachments(params[:attachment_ids], @question)
  end

  def title
    @title = @question.title
  end


  # Generates list of questions by criteria. If tags — by tags.
  # Also generates title for application layout
  # @param params[:action] [string] — takes it and sends to scope
  # @return [objects] from Question class
  def sort
    action = params[:action] == 'index' ? 'recent' : params[:action]
    if params[:tag]
      @title = params[:tag]
      @questions = Question.send(action).tagged_with(params[:tag]).page(params[:page])
      render 'questions/index'
    else
      @title = action.capitalize
      @questions = Question.send(action).page(params[:page])
      render 'questions/index'
    end
  end

  def set_question
    @question ||= Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :tag_list)
  end

end
