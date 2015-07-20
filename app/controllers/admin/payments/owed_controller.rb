class Admin::Payments::OwedController < Admin::ApplicationController
  expose(:payments) { @payments }

  def index
    @payments = Payment
      .select('payments.company_id, sum(amount) as total')
      .includes(:company)
      .group('payments.company_id')
  end
end
