class WikiPolicy < ApplicationPolicy    

  def index?
    true
  end

  def show?
    user.present?
  end

  def create?
    user.present?
  end

  def new?
    user.present?
  end
  
end