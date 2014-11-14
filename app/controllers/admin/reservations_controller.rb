class Admin::ReservationsController < Admin::ApplicationController
  include Admin::CompanyRequired

  before_action :set_reservation, only: [:show, :destroy]
  require_role :admin, :company

  # GET /admin/reservations
  # GET /admin/reservations.json
  def index
    @q = reservations_finder.ransack(params[:q])
    @reservations = @q.result.includes(:airport, :company)

    respond_to do |format|
      format.html { @reservations = paginate_model @reservations }
      format.csv  { send_csv_file 'Reservation', @reservations }
    end
  end

  # GET /admin/reservations/1
  # GET /admin/reservations/1.json
  def show
  end

  # DELETE /admin/reservations/1
  # DELETE /admin/reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to admin_reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = reservations_finder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:airport_id, :company_id, :flight_datetime,
        :pickup_datetime, :passenger_name, :phone, :num_of_passengers, :net_fare,
        :gratuity, :addresss, :cross_street, :airline, :luggage, :cancelation_reason,
        :flight_number, :status, :service_type
      )
    end

    def reservations_finder
      current_user.admin? ? Reservation : current_user.reservations
    end
end
