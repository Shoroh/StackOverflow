class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:edit]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user.profile
  end

end