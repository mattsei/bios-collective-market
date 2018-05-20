class OrderMailer < ApplicationMailer
  default from: 'noreply@bioscollective.com'

  def send_order_email(user)
    @user = user
    mail(to: @user.email, subject: 'Order successful')
  end
end
