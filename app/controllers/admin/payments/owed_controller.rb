class Admin::Payments::OwedController < Admin::ApplicationController
  expose(:payments) { @payments }

  def index
    @payments = Payment
      .select('payments.company_id, SUM(amount) as total, MAX("from") as "from", MAX("to") as "to"')
      .includes(:company)
      .group('payments.company_id')
  end
end
