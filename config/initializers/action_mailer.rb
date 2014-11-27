if Rails.env.production? || Rails.env.staging?
  ActionMailer::Base.smtp_settings = {
    :user_name => 'naturaily',
    :password => 'empathy3',
    :domain => 'www.shuttlefare.com',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }
elsif Rails.env.development?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :user_name => '2687516457f4d1f4a',
    :password => '1a9fd1a4a03657',
    :address => 'mailtrap.io',
    :domain => 'mailtrap.io',
    :port => '2525',
    :authentication => :cram_md5
  }
else
  ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
end
