class Admin::PaymentsController < Admin::ApplicationController
  def index
    @payments = Payment.all
  end

  def create
    @payment = Payment.new payment_params
    if @payment.save
      json_response_success message: 'Payment has been created'
    else
      json_response_error message: @payment.errors.full_messages.join(', ')
    end
  end

  protected

  def payment_params
    params.require(:payment).permit(:company_id, :from, :to)
  end
end
