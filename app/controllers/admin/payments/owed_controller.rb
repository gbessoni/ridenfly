class Admin::Payments::OwedController < Admin::ApplicationController
  expose(:payments) { @payments }

  def index
    @payments = Payment
      .select('payments.company_id')
      .select('SUM(payments.amount - payments.net_commission) as owed_total')
      .select('MIN("from") as "from", MAX("to") as "to"')
      .includes(:company)
      .group('payments.company_id')
  end
end
