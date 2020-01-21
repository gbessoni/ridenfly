desc 'Send daily manifest to companies'
task reservation_reminder: :environment do
  start_time = Time.zone.tomorrow.beginning_of_day
  company_ids =
    Reservation.
      joins(:rate).
      active.
      where(pickup_datetime: start_time..start_time.end_of_day).
      uniq.
      pluck('rates.company_id')

  Company.where(id: company_ids).all.each do |company|
    CompanyMailer.reminder(company).deliver_now
  end
end
