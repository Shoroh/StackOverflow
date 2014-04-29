class Question < ActiveRecord::Base
  belongs_to :user
  validates :title, :body, :presence => true
  validates :title, length: { in: 5..80 }
end
