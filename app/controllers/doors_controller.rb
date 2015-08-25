class DoorsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_user
  before_filter :set_twilio, only: [:welcome, :assign_number]

  layout "devise", only: [:welcome]

  def welcome
    user_country_code = params[:user_country_code] || session[:compatibility_check_country_code]
    if user_country_code.present?

      begin
        if ['US', 'CA'].include? user_country_code
          @available_phone_numbers = @twilio.account.available_phone_numbers.get(user_country_code).local.list(capabilities: 'voice', address_requirements: 'none', area_code: params[:area_code])
        else
          @available_phone_numbers = @twilio.account.available_phone_numbers.get(user_country_code).local.list(capabilities: 'voice', address_requirements: 'none', contains: params[:area_code])
        end
      rescue StandardError => e
        Rails.logger.debug(e)
        flash[:alert] = "A network error occurred."
      end
    end
  end

  def assign_number
    begin
      number = @twilio.account.incoming_phone_numbers.create(:phone_number => params[:phone_inbound])
      number.update(:voice_url => "#{root_url}twilio/receive_call")
    rescue StandardError => e
      flash[:alert] = "An error occurred: #{e.message}"
      return redirect_to welcome_door_path
    end

    @user.phone_inbound = number.phone_number.phony_formatted(:format => :international, spaces: '')
    @user.country_code = params[:user_country_code]
    @user.plan_name = 'office'
    @user.timezone = 'UTC'
    @user.save!
    return redirect_to door_path
  end
	
  def show
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    if @user.update(user_params)
      redirect_to :door, notice: 'Door was successfully updated.'
    else
      render :show
    end
  end

  private

    def set_user
      @user = current_user
    end

    def set_twilio
      @twilio = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
    end

  	def user_params
  		params.require(:user).permit(
  			:plan_name,
  			:dtmf,
  			:timezone,
  		)
  	end

end
