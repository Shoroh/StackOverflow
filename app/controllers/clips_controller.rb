class ClipsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def create
    if params[:files]
      params[:files].each do |file|
        @clip = Clip.create(file: file)
      end
    end
  end



  private

  def clip_params
    params.require(:clip).permit(:file, files:[])
  end

end