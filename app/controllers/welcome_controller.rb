class WelcomeController < ApplicationController

  # Root page
  def index
    @questions = Question.recent.page(params[:page])
    render 'questions/index'
  end
end
