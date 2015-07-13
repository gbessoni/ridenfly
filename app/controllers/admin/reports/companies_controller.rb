class Admin::Reports::CompaniesController < Admin::ApplicationController
  require_role :admin

  expose(:companies) { @companies }
  expose(:q) { Ransack::SearchDecorator.decorate @q }

  def index
    @q = Rate.ransack(params[:q])
    @companies = paginate_model @q.result
      .select("rates.company_id as id")
      .select("companies.name as company_name")
      .select("reservations.status as reservation_status")
      .select("SUM(reservations.net_fare) as net_fare_total")
      .joins(:company)
      .joins(:reservations)
      .where('reservations.status': 'active')
      .group('rates.company_id, companies.name, reservations.status')
      .order('companies.name ASC')
  end
end
