class UserNotifier < ApplicationMailer
  default :from => 'do-not-reply@secretalbums.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for secret albums' )
  end
  
  def send_order_received_email(user, order)
    @user = user
    @order = order
    mail( :to => @user.email, :subject => "Your secret album order \"#{@order.album.name}\" was received!")
    # send notification to our worker.
  
  end
  
  def send_order_received_email_to_system(user, order)
    @user = user
    @order = order
    mail( :to => "help@secretalbums.com", :subject => "Customer \"#{@user.name}\" order \"#{@order.album.name}\" was received!")
  end
  
  def send_order_in_progress_email(user, order)
    @user = user
    @order = order
    mail(:to => @user.email, :subject => "Your secret album order \"#{@order.album.name}\" is in Progress now!")
  end
  
  def send_order_shipped_email(user, order)
    @user = user
    @order = order
    mail(:to => @user.email, :subject => "Your secret album order \"#{@order.album.name}\" has shipped!")
  end
  
  def send_order_cancel_request_email_to_system(user, order)
    @user = user
    @order = order
    mail( :to => "help@secretalbums.com", :subject => "Customer \"#{@user.name}\" order \"#{@order.album.name}\" request cancelation!")
  end  
  
  def send_order_cancel_request_email(user, order)
    @user = user
    @order = order
    mail( :to => @user.email, :subject => "Your secret album order \"#{@order.album.name}\" cancelation request has been sent!")
  end  

  def send_order_undo_cancel_request_email_to_system(user, order)
    @user = user
    @order = order
    mail( :to => "help@secretalbums.com", :subject => "Customer \"#{@user.name}\" order \"#{@order.album.name}\" has undo cancelation!")
  end    

  def send_order_undo_cancel_request_email(user, order)
    @user = user
    @order = order
    mail( :to => @user.email, :subject => "Your Secret Album order \"#{@order.album.name}\" undo cancelation request has been sent!")
  end
  
  def send_order_cancel_confirm_email(user, order)
    @user = user
    @order = order
    mail( :to => @user.email, :subject => "Your Secret Album order \"#{@order.album.name}\" has been cancel!")
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
