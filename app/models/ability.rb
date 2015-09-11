class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :read, Page, role_id: nil, public: true
      can :read, News, active: true, role_id: nil, public: true
      can :read, Event
      return
    end

    if user.admin? || user.has_role?(:administrator)
      can :manage, :all
      can :access, :admin
      can :create, News
      can :create, Event
      can :create, Letter
      can :create, Slide
      can :manage, Text
      can :manage, User
      can :import, [User]
      can :function, User
    else
      if user.has_role?(:functionary)
        can :function, User
      end
      can :manage, User, id: user.id
      can :create, Topic
      can :manage, Topic, user_id: user.id
      can :read, :all
      can :comment, News
      can :participate, Event

      cannot :read, [Page, News, Topic]
      can :read, [Page, News, Topic], role: nil
      can :read, [Page, News, Topic], role: { users: { id: user.id } }
    end
  end
end
