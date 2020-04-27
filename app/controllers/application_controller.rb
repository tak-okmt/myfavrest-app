class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        # If you have extra params to permit, append them to the sanitizer.
        def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_in, keys: [:user_id])
        end
end
