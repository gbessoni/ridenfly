class Admin::ApplicationController < ApplicationController
  include RequireRole

  before_action :authenticate_user!

  protected

  def send_csv_file(model)
    model_name = model.class.to_s.gsub('::ActiveRecord_Relation', '')
    options = {filename: "#{model_name.underscore.pluralize}.csv", type: :csv}
    send_data(
      "::Export::#{model_name}".constantize.new(model.all).to_csv,
      options
    )
  end

  def paginate_model(model, options = {})
    model.paginate(page: params[:page], per_page: 20)
  end
end
