xml.Response do
	xml.Say 'Opening door.'
	xml.Play(digits: @user.dtmf)
  xml.Pause(length: 2)
  xml.Play(digits: @user.dtmf)
  xml.Pause(length: 2)
end
