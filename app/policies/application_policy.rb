class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    record.publicly_viewable? || (record.user == user || user.admin?)
  end

  def show?
    record.publicly_viewable? || (record.user == user || user.admin?)
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && (record.user == user || user.admin?)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def scope
    record.class
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

