class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_receipt(user_name, user_email, order, total_amount)
    @user = user_name
    @order  = order
    @total_amount = total_amount
    mail(to: user_email, subject: "Thank you for your order ##{@order.id}")
  end
end
