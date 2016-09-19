#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.smtp_settings = {
#    :port      => 587,
#    :address   => "smtp.mailgun.org",
#    :user_name => ENV['MAILGUN_USERNAME'],
#    :password  => ENV['MAILGUN_PASSWORD'],
#  }

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :authentication => :plain,
  :address => "smtp.mailgun.org",
  :port => 587,
  :domain => ENV['MAILGUN_DOMAIN'],
  :user_name => ENV['MAILGUN_USERNAME'],
  :password => ENV['MAILGUN_PASSWORD']
}