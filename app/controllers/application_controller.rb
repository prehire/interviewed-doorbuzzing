class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Devise
  def after_sign_in_path_for(resource)
  	if current_user.phone_inbound.blank?
  		welcome_door_path
  	else
	    request.env['omniauth.origin'] || stored_location_for(resource) || door_path
  	end
  end

end