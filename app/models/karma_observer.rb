class KarmaObserver < ActiveRecord::Observer
  observe :question, :answer, :vote

  def after_create(record)
    Karma.increase(record)
  end

  def after_destroy(record)
    Karma.create(karmable: record, user: record.try(:votable).try(:user) || record.user, score: - Karma.send(record.class.to_s.underscore), action: 'decrease')
  end

end
