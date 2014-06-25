class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.admin? ? admin_abilities : user_abilities(user)
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, [Question, Answer, Comment]
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities(user)
    can :read, :all
    can :index, :all

    # Для голосования
    can :like, [Question, Answer]
    can :destroy, Vote

    can :create, [Question, Answer, Comment, Attachment]
    can :update, [Question, Answer, Comment], user: user
    can :destroy, [Question, Answer, Comment, Attachment], user: user
  end

end
