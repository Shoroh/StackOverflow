class Clip < ActiveRecord::Base
  belongs_to :answer
  #validates_presence_of :answer
  mount_uploader :file, FileUploader

end
