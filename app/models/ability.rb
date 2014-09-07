class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, :all
        can :access, :admin
        can :create, News
      else
        can :manage, User, id: user.id
        can :create, Topic
        can :manage, Topic, user_id: user.id
        can :read, :all
        # cannot :read, Page do |page|
        #   page.locked?
        # end
      end
    else
      cannot :read, :all
    end
  end
end
