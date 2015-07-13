class Admin::ApplicationController < ApplicationController
  include RequireRole
  include SendCsvFile
  include HtmlResponse
  include ModelPaginator
  include JsonResponse

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound do
    flash[:error] = 'Record not found!'
    redirect_to admin_root_url
  end
end
