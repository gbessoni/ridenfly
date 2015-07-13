class Admin::Reports::ReservationsController < Admin::ApplicationController
  require_role :admin

  expose(:reservations) { @reservations }

  def index
    @q = Reservation.ransack(params[:q])
    @reservations = @q.result
      .order('status ASC, created_at DESC')

    json_response_success html: render_table, company_id: @q.company_id_eq
  end

  protected

  def render_table
    render_to_string partial: 'table', formats: [:html]
  end
end
