class WholesalersController < ApplicationController
  def index
    @apps = Wholesaler.all
  end

  def new
    authenticate_customer!
    @wholesaler = Wholesaler.new
    render 'new.html.erb'
  end

  def create
    authenticate_customer!
    @wholesaler = Wholesaler.create(wholesaler_params.merge(customer_id: current_customer.id))
    if @wholesaler.save
      # This sends email to all employees
      @employees = Employee.where(admin: true)
      @employees.each do |employee|
        UserMailer.wholesaler_email_to_admin(employee, @wholesaler).deliver_later
      end

      render 'create.html.erb'
    else
      render 'new.html.erb'
    end
  end

  def show
    if current_employee
      @wholesaler = Wholesaler.find(params[:id])
    elsif current_customer&.wholesaler
      @wholesaler = current_customer.wholesaler
    else
      flash[:warning] = 'You have not submitted an application!'
      redirect_to '/'
    end
  end

  def edit
    if !signed_in?
      redirect_to '/customers/sign_in'
    elsif current_customer&.wholesaler
      @wholesaler = current_customer.wholesaler
    elsif current_employee
      @wholesaler = Wholesaler.find(params[:id])
    else
      flash[:warning] = 'You have not submitted an application!'
      redirect_to '/'
    end
  end

  def update
    @wholesaler = Wholesaler.find(params[:id])
    if wrong_user
      redirect_to '/customers/sign_in'
    elsif @wholesaler.update(wholesaler_params)
      if params[:is_approved] == 'true'
        UserMailer.approved_email(@wholesaler).deliver_now
        flash[:success] = 'Approved!'
      end
      if params[:is_rejected] == 'true'
        UserMailer.rejection_email(@wholesaler).deliver_now
        flash[:success] = 'Rejected!'
      end
      redirect_to '/wholesalers'
    else
      flash[:warning] = 'Something went wrong.'
      render :edit
    end
  end

  def wrong_user
    (current_customer && params[:id].to_i != current_customer&.wholesaler&.id) ||
      (current_customer.nil? && current_employee.nil?)
  end

  private

  def wholesaler_params
    safe_params = params.permit(
      :business_name,
      :contact_name,
      :work_phone,
      :billing_address,
      :billing_city,
      :billing_state,
      :billing_zip_code,
      :shipping_address,
      :shipping_city,
      :shipping_state,
      :shipping_zip_code,
      :website,
      :accounts_payable_contact_name,
      :accounts_payable_contact_email,
      :accounts_payable_contact_phone,
      :retailer,
      :tax_exempt,
      :delivery_instructions,
      :recieving_hours,
      :days_closed
    )
    safe_params.merge!(params.permit(:is_approved, :is_rejected)) if current_employee
    safe_params
  end
end
