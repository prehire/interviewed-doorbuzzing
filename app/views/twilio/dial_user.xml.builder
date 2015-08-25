# If params[:destination_id] is provide, this is a callback
if params[:min_sequence].present?
	min_sequence = @user.destinations.where("sequence > ?", params[:min_sequence]).order(:sequence).map{|d| d.sequence}.min
	destinations = @user.destinations.where(sequence: min_sequence)
else
	min_sequence = @user.destinations.order(:sequence).map{|d| d.sequence}.min
	destinations = @user.destinations.where(sequence: min_sequence)
end

xml.Response do
	if destinations.size > 0
		xml.Dial(timeout: 10, action: "/twilio/dial_user_callback.xml?min_sequence=#{min_sequence}") do
			destinations.each do |destination|
				xml.Number destination.phone
			end
		end
	else
		xml.Say('Sorry, no one answered.')
		xml.Hangup
	end
end
