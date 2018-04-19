class UserMailer < ApplicationMailer
  default from: 'email_boty@email.com'

  def wholesaler_email_to_admin(employee, wholesaler)
    @wholesaler = wholesaler
    mail(to: employee.email, subject: 'New Wholesaler Application')
  end
end
