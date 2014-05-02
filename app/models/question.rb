class Question < ActiveRecord::Base
  belongs_to :user, counter_cache: true

  validates :title, :body, :presence => true

  validates :title, length: 20..255
  validates :body, length: 20..6000


  enum status: {
      active:       0,
      solved:       1,
      has_answer:   2,
      featured:     3,
      deleted:      4,
      archived:     5,
      pending:      6
  }

  scope :recent do
    
  end

end
