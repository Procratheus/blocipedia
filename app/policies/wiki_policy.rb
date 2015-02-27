class WikiPolicy < ApplicationPolicy    

  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present? && user.role == "premium"
  end
end