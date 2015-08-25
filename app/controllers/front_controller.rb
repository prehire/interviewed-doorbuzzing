class FrontController < ApplicationController

  layout "devise", except: [:index]

  def index
  end

  def check_compatibility
    Visitor.create(phone: params[:phone], country_code: params[:user_country_code])

    # Was not submitted from home page
    if params.include?(:user_country_code)
      alerts = []
      alerts << "Please select your country." if params[:user_country_code].blank?
      alerts << "Please enter your phone number." if params[:phone].blank?
      
      phone = params[:phone].phony_normalized(:format => :international, spaces: '', country_code: params[:user_country_code])

      puts "Phot is #{phone}"

      if phone.blank?
        alerts << "Your phone number is invalid as entered." 
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
        flash[:alert] = alerts.join(" ")
      else
        flash[:alert] = nil
        flash[:compatible_flag] = true

        #Save params for later use
        session[:compatibility_check_country_code] = params[:user_country_code]
        session[:compatibility_check_phone] = params[:phone]

        return redirect_to new_user_registration_path
      end
    end

  end

end



  def dial_sat_to_agent
    @agent = ::Account.find(params[:agent_id])
    
    unless @agent.sat_owner 
      return redirect_to :back, alert: "Agent has no SAT owner"
    end
    unless @sat_phone = TwilioHelper.clean_phone_number(@agent.sat_owner.phone)
      return redirect_to :back, alert: "You do not have a phone number set"
    end
    unless @sat_twilio_forwarding_phone = TwilioHelper.clean_phone_number(@agent.sat_owner.twilio_forwarding_phone)
      return redirect_to :back, alert: "You do not have a twilio forwarding phone number set"
    end
    unless @destination_number = TwilioHelper.clean_phone_number(params[:destination_number])
      return redirect_to :back, alert: "The agent does not have a phone number set"
    end

    if params['Digits'].blank? && params['AccountSid'].blank?
      @base_url = Rails.env.development? ? "#{request.base_url}/ops" : request.base_url

      begin
        @call = MLS.twilio.account.calls.create(
          from: TWILIO_SETTINGS[:default_from],
          to: @sat_phone,
          url: "#{@base_url}/twilio/dial_sat_to_agent.xml?agent_id=#{@agent.id}&destination_number=#{@destination_number}"
        )
      rescue EOFError, IOError
        return redirect_to :back, alert: "The call failed on the server.  Please try again."
      end
    elsif params['Digits'].present?
      Ops::SatAccountEvent.create!(
        agent: @agent,
        assigned_to: @agent.sat_owner,
        name: 'call_started'
      )
    end

    respond_to do |format|
      format.html {
        flash[:notice] = 'Press any key when your phone rings to dial the lead.'
        redirect_to edit_sat_account_path(@agent)
      }
      format.xml
    end

  end