class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachmentable, only: :create
  before_action :set_attachment, except: :create
  before_action except: :create do
    check_permissions(@attachment)
  end

  def create
    if params[:files]
      params[:files].each do |file|
        @attachment = @attachmentable.attachments.create(file: file)
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

  def set_attachmentable
    @attachmentable = params[:attachmentable_type].classify.constantize.find(params[:attachmentable_id])
  end

end