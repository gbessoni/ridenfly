module Admin::AbilitiesHelper
  def current_admin?
    current_user.try(:admin?)
  end

  def current_company?
    current_user.try(:company?)
  end
end
