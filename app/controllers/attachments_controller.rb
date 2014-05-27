class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachment, except: :create
  before_action except: :create do
    check_permissions(@attachment)
  end
  respond_to :js

  def create
    if params[:files]
      params[:files].each do |file|
        @attachment = Attachment.create(file: file, attachmentable_type: params[:attachmentable_type], attachmentable_id: params[:attachmentable_id] || nil)
        @attachment.user = current_user
        @attachment.save
      end
    end
  end

  def destroy
    @attachment.destroy
  end

  private

  def set_attachment
    @attachment ||= Attachment.find(params[:id])
  end

end