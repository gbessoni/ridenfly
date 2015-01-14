class Api::ReservationsController < Api::ApplicationController
  before_action :set_reservation, only: [:show, :update]
  after_action :log_json_response, only: [:index, :show, :create]

  # GET /api/reservations
  # GET /api/reservations.json
  def index
    @q = Reservation.ransack(params[:q])
    @reservations = paginate_model @q.result.includes(rate:[:airport, :company])
  end

  # GET /api/reservations/1
  # GET /api/reservations/1.json
  def show
    @reservations = [@reservation, @reservation.sibling].compact
  end

  # POST /api/reservations
  # POST /api/reservations.json
  def create
    @reservations = reservations_params.map do |rez_attrs|
      Reservation.new(rez_attrs)
    end

    respond_to do |format|
      if @reservations.first.save
        if @reservations.last.new_record?
          @reservations.last.save!
          @reservations.first.update(sibling: @reservations.last)
        end
        CustomerMailer.reservation_email(@reservations.first).deliver_now
        format.json { render :show, status: :created }
      else
        format.json { render json: reservation_errors(@reservations), status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/reservations/1
  # PATCH/PUT /api/reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        @reservations = [@reservation]
        format.json { render :show, status: :ok }
      else
        format.json { render json: reservation_errors([@reservation]), status: :unprocessable_entity }
      end
    end
  end

  private

    def set_reservation
      @reservation = Reservation.find(params[:id] || params[:reservation_id])
    end

    def reservations_params
      params.require(:reservations).map do |reservation|
        reservation.permit(*reservation_allow_attrs)
      end
    end

    def reservation_params
      params.require(:reservation).permit(*reservation_allow_attrs)
    end

    def reservation_allow_attrs
      [ :rate_id, :flight_datetime, :pickup_datetime, :passenger_name,
        :phone, :adults, :children, :flight_type, :email, :net_fare, :gratuity,
        :address, :cross_street, :airline, :luggage, :flight_number,
        :trip_direction
      ]
    end

    def reservation_errors(reservations)
      { errors: reservations.map{|r| r.errors.full_messages }.flatten }
    end
end
