class Question < ActiveRecord::Base
  validates :title, :body, :presence => true
  validates :title, length: { in: 5..80 }
end
