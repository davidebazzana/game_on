# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end

    can :read, Game
    can :create, User
    return unless user.present?
    can [:create, :vote, :play, :add_to_favorites], Game
    can [:remove_from_favorites], Game do |game|
      game.favorited_by? user
    end
    can [:update, :destroy], Game, user_id: user.id
    can [:create, :read], Review
    can [:update, :destroy], Review, user_id: user.id
    cannot :create, User
    can [:read], User
    can [:invite], User do |u|
      u.friend_with? user
    end
    can [:contact, :follow, :unfollow], User do |u|
      u.id != user.id
    end
    can [:update, :destroy, :read_favorites_list], User, id: user.id
    # can [:read, :update], Favorite, user_id: user.id
    return unless user.role == "moderator" || user.role == "admin"
    can [:manage], Review
    can [:destroy], Game
    return unless user.role == "admin"
    can [:destroy, :assign_role], User do |u|
      u.id != user.id
    end
    can [:manage], Game

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
