class DiaryPolicy < ApplicationPolicy
  def show?
    update?
  end
end