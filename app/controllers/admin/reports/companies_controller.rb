class Admin::Reports::CompaniesController < Admin::ApplicationController
  require_role :admin

  expose(:companies) { @companies }
  expose(:q) { Ransack::SearchDecorator.decorate @q }

  def index
    @q = Rate.ransack(query_params)
    @companies = paginate_model @q.result
      .select("rates.company_id as id")
      .select("rates.company_id as company_id")
      .select("companies.name as company_name")
      .select("reservations.status as reservation_status")
      .select("SUM(reservations.net_fare) as net_fare_total")
      .joins(:company)
      .joins(:reservations)
      .includes(:payments)
      .where('reservations.status' => 'active')
      .group('rates.company_id, companies.name, reservations.status')
      .order('companies.name ASC')
  end

  protected

  def query_params
    if params[:q].present?
      params[:q]
    elsif params[:payment]
      { reservations_pickup_datetime_start_date_gteq: params[:payment][:from],
        reservations_pickup_datetime_end_date_lteq: params[:payment][:to]
      }
    else
      {}
    end
  end
end
