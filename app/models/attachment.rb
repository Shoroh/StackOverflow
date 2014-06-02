# User can add files to his questions and his answers. Using carrierwave gem.
class Attachment < ActiveRecord::Base
  belongs_to :attachmentable, polymorphic: true
  belongs_to :user
  mount_uploader :file, FileUploader

  private

  def self.assign_attachments(params, object)
    if params
      params.split(",").each do |attachment|
        attachment = Attachment.find(attachment)
        attachment.attachmentable = object if attachment.attachmentable_id == nil
        attachment.save
      end
    end
  end

  def self.create_attachments(files, type, id, current_user)
    if files
      files.each do |file|
        # TODO тип можно не указывать!
        @attachment = Attachment.create(file: file, attachmentable_type: type, attachmentable_id: id, user: current_user)
      end
    end
    return @attachment
  end

end
