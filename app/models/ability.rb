class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, Page, public: true
      can :read, News, active: true
      return
    end

    if user.admin?
      can :manage, :all
      can :access, :admin
      can :create, News
      can :create, Event
    else
      if user.has_role? :moderator
        can :moderate, :all
        can :create, News
        can :create, Event
      end
      can :manage, User, id: user.id
      can :create, Topic
      can :manage, Topic, user_id: user.id
      can :read, :all
      can :comment, News
    end
  end
end
