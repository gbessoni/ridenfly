class CompanyMailer < ActionMailer::Base
  default from: "admin@ridenfly.com"

  def reminder(company, recipient = nil)
    recipient ||= company.user.email

    mail(
      to: recipient,
      bcc: company.confirmation_emails&.split(',')&.map(&:strip),
      subject: 'You have at least 1 ride scheduled for tomorrow',
    )
  end
end
