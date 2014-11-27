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
end
