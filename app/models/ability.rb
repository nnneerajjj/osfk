class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, Page, public: true
      can :read, News, active: true
      can :read, Event
      return
    end

    if user.admin?
      can :manage, :all
      can :access, :admin
      can :create, News
      can :create, Event
      can :create, Letter
      can :manage, User
    else
      if user.has_role? :administrator
        can :moderate, :all
        can :access, :admin
        can :create, News
        can :create, Event
        can :create, Letter
        can :manage, User
      end
      can :manage, User, id: user.id
      can :create, Topic
      can :manage, Topic, user_id: user.id
      can :read, :all
      can :comment, News
      can :participate, Event
    end
  end
end
