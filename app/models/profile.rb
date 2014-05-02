class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  accepts_nested_attributes_for :user

  validates :display_name, format: {with: /\A[a-z 0-9\-_\w]+\Z/i}, length: 3..80, allow_blank: true
  validates :facebook_id, format: {with: /\A[a-z\d.]+\Z/i}, length: 5..100, allow_blank: true
  validates :age, numericality: {less_than: 100, only_integer: true}, allow_blank: true

end
