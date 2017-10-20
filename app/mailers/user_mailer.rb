class UserMailer < ApplicationMailer
  default from: 'email_boty@email.com'
  def send_wholesaler_email
    @employees = Employee.all
    @employees.each do |employee|
      mail(to: employee.email, subject: 'New wholesale application recieved')
    end
  end
end
