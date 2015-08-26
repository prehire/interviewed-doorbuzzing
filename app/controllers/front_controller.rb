class FrontController < ApplicationController
  layout 'devise', except: [:index]

  def index
  end

  def check_compatibility
    Visitor.create(phone: params[:phone], country_code: params[:user_country_code])

    # Was not submitted from home page
    if params.include?(:user_country_code)
      alerts = []
      alerts << 'Please select your country.' if params[:user_country_code].blank?
      alerts << 'Please enter your phone number.' if params[:phone].blank?

      phone = params[:phone].phony_normalized(format: :international, spaces: '', country_code: params[:user_country_code])

      if phone.blank?
        alerts << 'Your phone number is invalid as entered.'
      else
        begin
          @twilio ||= Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
          @call = @twilio.account.calls.create(
            from: Rails.application.secrets.twilio_default_from,
            to: phone,
            url: "#{root_url}twilio/check_compatibility"
          )
        rescue EOFError, IOError, Twilio::REST::RequestError => e
          alerts << "The test call failed: #{e.message}"
        end
      end

      if alerts.present?
        flash[:alert] = alerts.join(' ')
      else
        flash[:alert] = nil
        flash[:compatible_flag] = true

        # Save params for later use
        session[:compatibility_check_country_code] = params[:user_country_code]
        session[:compatibility_check_phone] = params[:phone]

        return redirect_to new_user_registration_path
      end
    end
  end
end
