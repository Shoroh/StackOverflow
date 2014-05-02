class Question < ActiveRecord::Base
  belongs_to :user, counter_cache: true

  validates :title, :body, :presence => true

  validates :title, length: 20..255
  validates :body, length: 20..6000

end
