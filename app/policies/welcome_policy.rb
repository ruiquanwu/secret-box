class WelcomePolicy < ApplicationPolicy
  def index?
    user.present?
  end
end