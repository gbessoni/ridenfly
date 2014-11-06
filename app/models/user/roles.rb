module User::Roles
  extend ActiveSupport::Concern

  included do
    serialize :roles, JSON
  end

  ADMIN   = 'admin'
  COMPANY = 'company'

  def admin?
    roles.include?(ADMIN)
  end

  def company?
    roles.include?(COMPANY)
  end
end
