class Admin::ApplicationController < ApplicationController
  include RequireRole
  include SendCsvFile
  include HtmlResponse

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do
    flash[:error] = 'Record not found!'
    redirect_to admin_root_url
  end

  protected

  def paginate_model(model, options = {})
    model.paginate(page: params[:page], per_page: 20)
  end
end
