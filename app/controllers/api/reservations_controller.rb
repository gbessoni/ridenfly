class Api::ReservationsController < Api::ApplicationController
  before_action :set_reservation, only: [:show, :update]

  # GET /api/reservations
  # GET /api/reservations.json
  def index
    @q = Reservation.ransack(params[:q])
    @reservations = paginate_model @q.result.includes(:airport, :company)
  end

  # GET /api/reservations/1
  # GET /api/reservations/1.json
  def show
  end

  # POST /api/reservations
  # POST /api/reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.json { render :show, status: :created, location: [:api, @reservation] }
      else
        format.json { render json: {reservation:{errors: @reservation.errors}}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/reservations/1
  # PATCH/PUT /api/reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.json { render :show, status: :ok, location: [:api, @reservation] }
      else
        format.json { render json: {reservation:{errors: @reservation.errors}}, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(
        :airport_id, :company_id, :flight_datetime, :pickup_datetime, :passenger_name,
        :phone, :num_of_passengers, :net_fare, :gratuity, :addresss, :cross_street,
        :airline, :luggage, :flight_number, :trip_direction
      )
    end
end
