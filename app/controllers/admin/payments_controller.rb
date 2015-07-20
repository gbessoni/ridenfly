class Admin::PaymentsController < Admin::ApplicationController
  require_role :admin

  expose(:payments) { @payments }

  def new
    @payment = Payment.new payment_params
  end

  def index
    @payments = Payment.paginate page: params[:page], per_page: 20
  end

  def create
    @payment = Payment.new payment_params
    if @payment.save
      json_response_success message: 'Payment has been created', reload: admin_payments_url
    else
      json_response_error message: @payment.errors.full_messages.join(', ')
    end
  end

  def update
    payment = find_payment
    payment.update_attributes paid: payment_params[:paid]
    json_response_success message: 'Payment has been updated.'
  end

  def destroy
    if find_payment.try(:destroy)
      flash[:notice] = 'Payment removed.'
    end
    redirect_to admin_payments_url
  end

  protected

  def find_payment
    Payment.where(id: params[:id]).first
  end

  def payment_params
    params.fetch(:payment, {}).permit(:company_id, :from, :to, :paid)
  end
end
