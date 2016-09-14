class UserNotifier < ApplicationMailer
  default :from => 'help@secretalbums.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for secret albums' )
  end
  
  def send_order_received_email(user)
    @user = user
    mail( :to => @user.email, :subject => "Your album order received!")
  end
  
  
  def send_simple_message
    RestClient.post "https://api:key-a8207edb0b55ad334cc072bf2888145f"\
    "@api.mailgun.net/v3/sandbox0d1adfe316c5475e882961c0155c7130.mailgun.org/messages",
    :from => "Mailgun Sandbox <postmaster@sandbox0d1adfe316c5475e882961c0155c7130.mailgun.org>",
    :to => "ruiquanwu <ruiquanwu@gmail.com>",
    :subject => "Hello ruiquanwu",
    :text => "Congratulations ruiquanwu, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
  end
end
