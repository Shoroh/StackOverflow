class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  validates :display_name, format: {with: /\A[a-z 0-9\-_\w]+\Z/i}, length: 3..80
  validates :facebook_id, format: {with: /\A[a-z\d.]+\Z/i}, length: 5..100
  validates :age, numericality: {less_than: 100, only_integer: true}

end
