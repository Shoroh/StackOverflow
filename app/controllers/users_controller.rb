class UsersController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  before_action :authenticate_user!, :only => [:edit, :update]
  before_action :set_user, :add_email, only: :add_email

  def add_email
    if params[:user] && params[:user][:email]
      current_user.email = params[:user][:email]

      # Note: When using the Devise confirmable module I choose to skip email validation
      # here if the user has signed up with Twitter.
      # Just remove the following line if you want the user to confirm their email address.
      # current_user.skip_reconfirmation!

      if current_user.save
        redirect_to current_user, notice: 'Your email address was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_path, :flash => {:info => "Profile was successfully updated!"} }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_profile
    if current_user
      @profile = current_user.profile
      @user = current_user
    end

  end

  def profile_params
    params.require(:profile).permit(:age, :display_name, :facebook_id)
  end

end