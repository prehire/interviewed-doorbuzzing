xml.Response do
  xml.Gather :method => "GET", :timeout => 20, :numDigits => 5, :finishOnKey=>"0", :action => "/twilio/enter_code.xml?attempt_count=#{@attempt_count}" do
    xml.Say 'If you have a pin code, enter it now. Otherwise, press 0 to request entry.'
  end
  xml.Redirect twilio_dial_user_callback_path
end
