class Karma < ActiveRecord::Base
  belongs_to :user
  belongs_to :karmable, polymorphic: true

  SCORES = {
      question: 20,
      answer:   10,
      vote:     15,
  }

  def self.method_missing(symbol)
    SCORES[symbol]
  end

end
