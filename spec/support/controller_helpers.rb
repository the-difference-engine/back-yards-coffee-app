module ControllerHelpers
  ## login_customer will give us current_customer in the rspec scope
  ## login_employee will give us current_employee in the rspec scope
  def login_customer
    @request.env["devise.mapping"] = Devise.mappings[:customer]
    customer = FactoryGirl.create(:customer)
    #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    sign_in customer
  end

  def login_client
    @request.env["devise.mapping"] = Devise.mappings[:employee]
    employee = FactoryGirl.create(:employee)
    #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
    sign_in employee
  end
end