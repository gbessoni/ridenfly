class CustomerMailer < ActionMailer::Base
  default from: "admin@ridenfly.com"

  def reservation_email(reservation)
    @reservation = reservation.decorate
    mail(
      to: reservation.rate.company.user.email,
      subject: "New reservation",
      sent_on: Time.now
    )
  end

  def cancelation_email(reservation)
    @reservation = reservation.decorate
    mail(
      to: reservation.rate.company.user.email,
      subject: "Reservation #{reservation.rezid} canceled",
      sent_on: Time.now
    )
  end
end
