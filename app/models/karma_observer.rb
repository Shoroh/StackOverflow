class KarmaObserver < ActiveRecord::Observer
  observe :question, :answer, :vote

  def after_create(record)
    case record.class.to_s
      when 'Question'
        record.user.profile.update(karma: record.user.karma + 20)
      when 'Answer'
        record.user.profile.update(karma: record.user.karma + 10)
      when 'Vote'
        record.votable.user.profile.update(karma: record.votable.user.karma + 15) unless record.votable.user == record.user
      else
        record.user.profile.update(karma: record.user.karma + 1)
    end
  end

  def after_destroy(record)
    case record.class.to_s
      when 'Question'
        record.user.profile.update(karma: record.user.karma - 20)
      when 'Answer'
        record.user.profile.update(karma: record.user.karma - 10)
      when 'Vote'
        record.votable.user.profile.update(karma: record.votable.user.karma - 15) unless record.votable.user == record.user
      else
        record.user.profile.update(karma: record.user.karma - 1)
    end
  end

end
