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

  private

  def self.increase(record)
    self.create(
        karmable: record,
        user: record.try(:votable).try(:user) || record.user,
        score: Karma.send(record.class.to_s.underscore) * (record.class == Vote ? 1 : 2 ),
        action: 'increase',
    )
  end

end
