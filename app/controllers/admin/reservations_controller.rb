class Admin::ReservationsController < Admin::ApplicationController
  include Admin::CompanyRequired

  before_action :set_reservation, only: [:show, :cancel, :edit, :update]
  require_role :admin, :company

  expose(:reservations) { @reservations.try(:decorate) }
  expose(:reservation)  { @reservation.try(:decorate) }

  # GET /admin/reservations
  # GET /admin/reservations.json
  def index
    if params[:q] && params[:q]['id_eq'].present?
      params[:q]['id_eq'].sub!(/[^\d]+/, '')
    end

    @q = reservations_finder.ransack(params[:q])
    @reservations = @q.result
      .includes(rate: [:airport, :company])
      .order('created_at desc')

    respond_to do |format|
      format.html { @reservations = paginate_model @reservations }
      format.csv  { send_csv_file 'Reservation', @reservations }
    end
  end

  # GET /admin/reservations/1
  # GET /admin/reservations/1.json
  def show
  end

  # PATCH/PUT /admin/reservations/1
  # PATCH/PUT /admin/reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to [:admin, @reservation], notice: 'reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /admin/reservations/1/edit
  def edit
  end

  def cancel
    @reservation.cancel params.permit(:cancelation_reason)
    respond_to do |format|
      format.html { redirect_to [:admin, @reservation], notice: 'Reservation was successfully cancelled.' }
      format.json { render :show, status: :ok, location: @reservation }
    end
  end

  def resend_confirmation_email
    @reservation = reservations_finder.find(params[:reservation_id])
    CustomerMailer.reservation_email(@reservation).deliver_now
    respond_to do |format|
      format.html { redirect_to admin_reservations_url, notice: 'Reservation email resend correctly.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = reservations_finder.find(params[:id])
    end

    def reservations_finder
      current_user.admin? ? Reservation : current_user.reservations
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:sub_status, :notes)
    end
end
