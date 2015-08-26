class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive_call
    @user = get_user

    # Schedules
    now_in_zone = Time.now.in_time_zone(@user.timezone)
    schedules = @user.schedules
                .where(day_of_week: now_in_zone.wday)
                .where("start_time::time <= '#{now_in_zone.strftime('%H:%M:%S')}'::time")
                .where("end_time::time >= '#{now_in_zone.strftime('%H:%M:%S')}'::time")
                .order(:created_at)
    schedule = schedules.first

    if schedule.present?
      return render :open_door
    elsif @user.codes.present?
      return render :gather_code
    else
      return render :dial_user
    end
  end

  def enter_code
    @user = get_user
    code = @user.codes.find_by(pin: params['Digits'])

    if code
      return render :open_door
    else code
         if params[:attempt_count]
           @attempt_count = params[:attempt_count].to_i + 1
         else
           @attempt_count = 1
         end

         if @attempt_count <= 3
           return render :gather_code
         else
           return render :dial_user
         end
    end
  end

  def dial_user_callback
    @user = get_user
    render :dial_user
  end

  def check_compatibility
  end

  private

  def get_user
    User.find_by(phone_inbound: params['To'].phony_normalized) || fail(ActiveRecord::RecordNotFound)
  end

  def set_twilio
    @twilio ||= Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
  end
end
