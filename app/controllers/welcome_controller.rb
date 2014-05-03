class WelcomeController < ApplicationController
  def index
    @questions = Question.recent.page(params[:page])
    render 'questions/index'
  end
end
