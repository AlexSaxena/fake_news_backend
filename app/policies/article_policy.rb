class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      Scope
    end
  end

  def index?
    true
  end

  def create?
    @user.journalist?
  end

  def show?
    @user.subscriber?
  end

  def update?
    @user.journalist?
  end
end