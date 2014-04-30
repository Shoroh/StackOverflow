class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show]

  def show

  end


  private

  def set_profile
    @profile = Profile.find_by_user_id(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:display_name, :age, :facebook_id)
  end
end