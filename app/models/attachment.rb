# User can add files to his questions and his answers. Using carrierwave gem.
class Attachment < ActiveRecord::Base
  belongs_to :attachmentable, polymorphic: true
  belongs_to :user
  mount_uploader :file, FileUploader
end
