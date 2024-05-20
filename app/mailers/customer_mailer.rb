class CustomerMailer < ApplicationMailer
  def send_mail_verify_login_id(customer_id, url)
    @customer = Customer.find(customer_id)
    @url = url
    mail(to: @customer.email, subject: 'Thông báo xác thực tài khoản')
  end

  def send_mail_forgot_password(customer, token)
    @token = token
    mail(to: customer.email, subject: 'Mã xác thực quên mật khẩu')
  end
end
