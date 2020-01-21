class CustomerMailer < ActionMailer::Base
  default from: "admin@ridenfly.com"

  def reservation_email(reservation)
    @reservation = reservation.decorate
    mail(
      to: reservation.company.user.email,
      bcc: reservation.company.confirmation_emails&.split(',')&.map(&:strip),
      subject: "New reservation for passenger #{reservation.passenger_name}",
      sent_on: Time.now
    )
  end

  def cancelation_email(reservation)
    @reservation = reservation.decorate
    mail(
      to: reservation.company.user.email,
      bcc: reservation.company.confirmation_emails&.split(',')&.map(&:strip),
      subject: "Reservation #{reservation.rezid} canceled",
      sent_on: Time.now
    )
  end
end
