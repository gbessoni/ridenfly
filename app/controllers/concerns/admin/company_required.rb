module Admin::CompanyRequired
  extend ActiveSupport::Concern

  included do
    before_action :require_company_unless_admin
  end

  protected

  def require_company_unless_admin
    if current_user.present? && !current_user.admin? && current_user.company.blank?
      flash[:error] = 'Company information is missing. Contact with administrator!'
      redirect_to admin_root_url
    end
  end
end
