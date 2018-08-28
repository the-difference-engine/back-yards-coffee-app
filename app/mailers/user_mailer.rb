class UserMailer < ApplicationMailer
  default from: 'info@by.coffee'

  def wholesaler_email_to_admin(employee, wholesaler)
    @wholesaler = wholesaler
    mail(to: employee.email, subject: 'New Wholesaler Application')
  end

  def rejection_email(wholesaler)
    @wholesaler = wholesaler
    mail(to: wholesaler.accounts_payable_contact_email, subject: 'Wholesaler Application Status')
  end

  def approved_email(wholesaler)
    @wholesaler = wholesaler
    mail(to: wholesaler.accounts_payable_contact_email, subject: 'Wholesaler Application Status')
  end
end
