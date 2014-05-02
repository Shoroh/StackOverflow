class WelcomeController < ApplicationController
  def index
    @questions = Question.recent
    render 'questions/index'
  end
end
