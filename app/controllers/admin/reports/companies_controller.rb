class Admin::Reports::CompaniesController < Admin::ApplicationController
  require_role :admin

  expose(:companies) { @companies }

  def index
    @q = Rate.ransack(params[:q])
    @companies = paginate_model @q.result
      .select("COUNT(*) as count")
      .select("companies.name as company_name")
      .select("SUM(reservations.net_fare) as net_fare_total")
      .joins(:company)
      .joins(:reservations)
      .group('rates.company_id, companies.name')
  end
end
