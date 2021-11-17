require 'authy'

class TwoFactorAuthentication
  attr_accessor :phone_number_with_code, :client, :verification_service, :otp

  def initialize(phone_number, otp = nil)
    Authy.api_uri = Constant::AUTHY_API_URI
    Authy.api_key = Constant::AUTHY_API_KEY
    @client = Twilio::REST::Client.new(Constant::ACCOUNT_SID, Constant::AUTH_TOKEN)
    @verification_service = client.verify.services(Constant::SERVICE_SID)
    @phone_number_with_code = "+91#{phone_number}"
    @otp = otp
  end

  def send_otp
    response = verification_service.verifications.create(to: phone_number_with_code, channel: 'sms')
    if response.lookup['carrier']['error_code'].nil?
      { success: true }
    else
      { success: false, message: response.lookup['carrier']['error_code'] }
    end
  end

  def verify_otp?
    binding.pry
    response = verification_service.verification_checks.create(to: phone_number_with_code, code: otp)
  end
end
