class UserPolicy < ApplicationPolicy

  def index?
    user.role == "premium" || user.role == "admin" ? true : false
  end

  def update_role?
    user.role == "premium"
  end

end