require 'rest-client'

module SensetimeAPI
  def self.selfie_idnumber_verification file, id, name
    url = 'https://v1-auth-api.visioncloudapi.com/identity/selfie_idnumber_verification'
    params = {
      selfie_file: file,
      api_id: ENV["SENSETIME_API_ID"],
      api_secret: ENV["SENSETIME_API_SECRET"],
      id_number: id,
      name: name
    }

    Rails.logger.debug "  Request #{url} with #{params}."
    result = RestClient.post(url, params)
    Rails.logger.debug "  Response: #{result}"
    JSON.parse result
  end
end
