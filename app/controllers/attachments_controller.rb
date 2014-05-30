class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachment, except: :create
  before_action except: :create do
    check_permissions(@attachment)
  end
  respond_to :js

  def create
    @attachment = Attachment.create_attachments(params[:files],
                                                params[:attachmentable_type],
                                                params[:attachmentable_id],
                                                current_user)
  end

  def destroy
    @attachment.destroy
  end

  private

  def set_attachment
    @attachment ||= Attachment.find(params[:id])
  end

end