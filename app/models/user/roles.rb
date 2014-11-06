module User::Roles
  extend ActiveSupport::Concern

  included do
    serialize :roles, JSON
  end

  ADMIN   = 'admin'
  COMPANY = 'company'

  ROLES = [
    ADMIN,
    COMPANY
  ]

  def admin?
    roles.include?(ADMIN)
  end

  def company?
    roles.include?(COMPANY)
  end

  def add_role(role)
    raise "Invalid role '#{role}'" unless ROLES.include?(role)
    self.roles = (roles << role).uniq
  end
end
