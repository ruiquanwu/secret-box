class AdminPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end
  
  def index?
    @user.admin?
  end
  
  def new?
    index?
  end
  
  def create?
    index?
  end
  
  def edit?
    index?
  end
  
  def update?
    index?
  end
  
  def destroy?
    index?
  end
  
  def show?
    index?
  end
end