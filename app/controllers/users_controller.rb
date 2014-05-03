class UsersController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  before_action :authenticate_user!, :only => [:edit, :update]

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