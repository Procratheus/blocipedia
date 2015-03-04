class WikiPolicy < ApplicationPolicy    

  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present? && (user.role == "premium" || user.role == "admin")
  end

  def new?
    user.present?
  end
  
end