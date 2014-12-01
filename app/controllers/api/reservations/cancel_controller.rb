class Api::Reservations::CancelController < Api::ReservationsController
  before_action :set_reservation, only: :create

  def create
    respond_to do |format|
      if @reservation.cancel(reservation_params)
        @reservations = [@reservation]
        format.json { render :show, status: :ok }
      else
        format.json { render json: reservation_errors([@reservation]), status: :unprocessable_entity }
      end
    end
  end

  protected

  def reservation_params
    params.require(:reservation).permit(:cancelation_reason)
  end    
end
