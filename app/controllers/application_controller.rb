class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :layout_by_resource

  def after_sign_in_path_for(resource_or_scope)
    '/customers/dashboard'
  end


  def layout_by_resource
    if devise_controller? && !(current_employee || current_customer)
      "devise"
    else
      "application"
    end
  end
end