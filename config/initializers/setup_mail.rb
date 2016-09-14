ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.delivery_method :smtp, {
    :port      => 587,
    :address   => "smtp.mailgun.org",
    :user_name => ENV['MAILGUN_USERNAME'],
    :password  => ENV['MAILGUN_PASSWORD'],
}