class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:customer).permit(:address, :address2, :first_name, :last_name, :city, :state, :zip_code, :email, :password, :password_confirmation)
  end
end
