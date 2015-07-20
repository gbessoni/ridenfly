class Admin::PaymentsController < Admin::ApplicationController
  expose(:payments) { @payments }

  def index
    @payments = Payment.paginate page: params[:page], per_page: 20
  end

  def create
    @payment = Payment.new payment_params
    if @payment.save
      json_response_success message: 'Payment has been created', reload: true
    else
      json_response_error message: @payment.errors.full_messages.join(', ')
    end
  end

  def destroy
    payment = Payment.where(id: params[:id]).first
    if payment.try(:destroy)
      flash[:notice] = 'Payment removed.'
    end
    redirect_to admin_payments_url
  end

  protected

  def payment_params
    params.require(:payment).permit(:company_id, :from, :to)
  end
end
