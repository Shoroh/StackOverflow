class WelcomeController < ApplicationController
  def index
    @questions = Question.limit(50).order(created_at: :desc)
    render 'questions/index'
  end
end
