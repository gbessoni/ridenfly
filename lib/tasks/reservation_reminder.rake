desc 'Send daily manifest to companies'
task reservation_reminder: :environment do
  start_time = Time.zone.now.beginning_of_hour + 2.days
  reservations =
    Reservation.
      joins(:rate).
      active.
      where(pickup_datetime: start_time..start_time.end_of_hour)

  reservations.each do |reservation|
    CompanyMailer.reminder(reservation).deliver_now
  end
end
