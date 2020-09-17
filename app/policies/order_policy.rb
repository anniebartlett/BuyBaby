class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def my_account?
    true
  end

  def checkout?
    true
  end

  def confirmation_page?
    true
  end

  def reviews?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
