class ApplicationController < ActionController::Base
  #test hound ci
  protect_from_forgery with: :exception

  layout :layout_by_resource
  after_filter :store_location

def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  return unless request.get? 
    if (request.path != "/customers/sign_in" &&
      request.path != "/customers/sign_up" &&
      request.path != "/customers/password/new" &&
      request.path != "/customers/password/edit" &&
      request.path != "/customers/confirmation" &&
      request.path != "/customers/sign_out" &&
      !request.xhr?) 
    session[:previous_url] = request.fullpath 
   end
  end


  #Overrides the default method for redirecting to home page given with devise. Simply returns the url/path.
  def after_sign_in_path_for(resource_or_scope)
      session[:previous_url] || "/#{resource_or_scope.class.name.downcase.pluralize}/dashboard"
  end

  def guest_or_customer_id
    customer_signed_in? ? current_customer.id : session['session_id'].gsub(/\D/, '').to_i / 10000000000
  end

  def layout_by_resource
    if devise_controller? && !(current_employee || current_customer)
      "devise"
    else
      "application"
    end
  end
end
