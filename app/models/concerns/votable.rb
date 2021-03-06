module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def like(user)
    unless voted?(user)
      self.votes.create(user: user, value: :like)
    end
  end

  def unlike(user)
    unless voted?(user)
      self.votes.create(user: user, value: 'unlike')
    end
  end

  def voted?(user)
    user.votes.exists?(votable_id: self.id, votable_type: self.class.name)
  end

end