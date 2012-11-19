class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    unless user.new_record?
      can :create, Message do |o|
        !user.banned?(o.forum_id) &&
        (user.human? || user.messages.empty?)
      end

      can :create, Topic do |o|
        !user.banned?(o.forum_id) &&
        (user.human? || user.topics.empty?)
      end

      can :manage, Message do |o|
        user.id == o.user_id || user.moderator?(o.forum_id)
      end

      can :manage, Topic do |o|
        user.id == o.user_id || user.admin?(o.forum_id)
      end

      can :manage, Forum do |o|
        user.sysadmin? || user.admin?(o.id)
      end

      can :manage, Role do |o|
        (!o.user || !o.user.sysadmin?) &&
        (user.sysadmin? || user.admin?(o.forum_id))
      end

      can :manage, User do |o|
        user.sysadmin?
      end
    end
  end
end
