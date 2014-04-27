class Question < ActiveRecord::Base
  validates :title, :body, :presence => true
  validates_length_of :title, within: 5..80, too_short: 'too short title', too_long: 'too long title'
end
