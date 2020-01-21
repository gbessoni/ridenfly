class CustomerMailer < ActionMailer::Base
  default from: "admin@ridenfly.com"

  def reminder(reservation, recipient = nil)
    @reservation = reservation.decorate
    company = reservation.company
    recipient ||= company.user.email

    mail(
      to: recipient,
      bcc: reservation.company.confirmation_emails&.split(',')&.map(&:strip),
      subject: "Reservation Reminder #{reservation.rezid}",
    )
  end
end
