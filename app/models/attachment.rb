# User can add files to his questions and his answers. Using carrierwave gem.
class Attachment < ActiveRecord::Base
  belongs_to :attachmentable, polymorphic: true
  belongs_to :user
  mount_uploader :file, FileUploader

  def self.create_attachments(params, object)
    if params
      params.split(",").each do |attachment|
        new_attachment = Attachment.find(attachment)
        new_attachment.attachmentable = object if new_attachment.attachmentable_id == nil
        new_attachment.save
      end
    end
  end

end
