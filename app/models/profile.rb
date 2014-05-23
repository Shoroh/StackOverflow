# Additional fields for User, like name, age, etc
class Profile < ActiveRecord::Base
  belongs_to :user

  validates :display_name, format: { with: /\A[a-z 0-9\-_\w]+\Z/i }, length: 3..80, allow_blank: true
  validates :facebook_id, format: { with: /\A[a-z\d.]+\Z/i }, length: 5..100, allow_blank: true
  validates :age, numericality: { less_than: 100, only_integer: true }, allow_blank: true
end
