class Question < ActiveRecord::Base
  belongs_to :user, counter_cache: true

  validates :title, :body, :presence => true
  validates :title, length: { minimum: 8 }
end
