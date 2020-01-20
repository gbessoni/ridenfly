desc 'Send daily manifest to companies'
task daily_manifest: :environment do
  tomorrow = Time.zone.now.tomorrow.beginning_of_day
  reservations_scope =
    Reservation.
      joins(:rate).
      active.
      where(pickup_datetime: tomorrow..(tomorrow + 1.day).end_of_day).
      order('rates.company_id')

  company_id = nil

  ComapnyMailer.manifest(company, company_reservations).deliver_now
end
