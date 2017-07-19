class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :layout_by_resource

  #Overrides the default method for redirecting to home page given with devise. Simply returns the url/path.
  def after_sign_in_path_for(resource_or_scope)
    "/#{resource_or_scope.class.name.downcase.pluralize}/dashboard"
  end

  def guest_or_customer_id
    customer_signed_in? ? current_customer.id : session['session_id']
  end

  def layout_by_resource
    if devise_controller? && !(current_employee || current_customer)
      "devise"
    else
      "application"
    end
  end
end
