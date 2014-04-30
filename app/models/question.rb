class Question < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  validates :title, :body, :presence => true
  validates :title, length: { in: 5..80 }
end
