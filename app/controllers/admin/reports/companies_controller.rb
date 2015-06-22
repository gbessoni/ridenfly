class Admin::Reports::CompaniesController < Admin::ApplicationController
  require_role :admin

  expose(:companies) { @companies }

  def index
    @q = Reservation.ransack(params[:q])
    @companies = paginate_model @q.result
      .select('reservations.*, companies.name as company_name')
      .select('SUM(net_fare) as net_fare_total')
      .group('rates.company_id, reservations.id, companies.name')
      .joins(:company)
  end
end
