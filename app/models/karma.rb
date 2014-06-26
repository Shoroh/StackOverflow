class Karma < ActiveRecord::Base
  belongs_to :user
  belongs_to :karmable, polymorphic: true

  SCORES = {
      question: 20,
      answer:   10,
      vote:     15,
  }

  attr_accessor :record

  def self.method_missing(symbol)
    SCORES[symbol]
  end

  def increase
    Karma.create(
        karmable: record,
        user: user,
        score: score * (record.class == Vote ? user.karma_power : 1 ),
        action: 'increase',
    )
    update_karma
  end

  def decrease
    Karma.create(
        karmable: record,
        user: user,
        score: - (score * (record.class == Vote ? user.karma_power : 1 )),
        action: 'decrease',
    )
    update_karma
  end

  def score
    SCORES[record.class.to_s.underscore.to_sym]
  end

  private

  def user
    @user ||= record.try(:votable).try(:user) || record.user
  end

  def update_karma
    user.profile.update_attributes!(karma: Karma.where(user: user).sum(:score))
  end

end
