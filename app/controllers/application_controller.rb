class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :layout_by_resource
  after_filter :store_location

  def store_location
    # store last url
    # this is needed for post-login redirect to whatever the user last visited.
    do_not_include = [
      'sign_in',
      'sign_up',
      'password/new',
      'password/edit',
      'confirmation',
      'sign_out',
      'dashboard'
    ]
    if !request.get? || (
      do_not_include.include?(request.path.split('customers/')[-1]) ||
      do_not_include.include?(request.path.split('employees/')[-1]) ||
      request.xhr?)
      return
    end
    session[:previous_url] = request.fullpath
  end

  # Overrides the default method for redirecting to home page given with devise. Simply returns the url/path.
  def after_sign_in_path_for(resource_or_scope)
    session[:previous_url] || "/#{resource_or_scope.class.name.downcase.pluralize}/dashboard"
  end

  def guest_or_customer_id
    customer_signed_in? ? current_customer.id : session['session_id'].gsub(/\D/, '').to_i / 10_000_000_000
  end

  def layout_by_resource
    if devise_controller? && !(current_employee || current_customer)
      'devise'
    else
      'application'
    end
  end

  def authenticate_customer_or_employee!
    unless current_customer || current_employee
      flash[:warning] = 'Please log in'
      redirect_to '/'
    end
  end

  def authenticate_employee_admin!
    return if current_employee&.admin
    flash[:error] = 'User does not have access'
    redirect_to '/'
  end
end
