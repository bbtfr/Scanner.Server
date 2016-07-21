require 'rest-client'

module SensetimeAPI
  def self.selfie_idnumber_verification file, id, name
    url = 'https://v1-auth-api.visioncloudapi.com/identity/selfie_idnumber_verification'
    params = {
      selfie_file: file,
      id_number: id,
      name: name
    }

    send_request url, params
  end

  def self.historical_selfie_verification image_id, file
    url = 'https://v1-auth-api.visioncloudapi.com/identity/historical_selfie_verification'
    params = {
      selfie_file: file,
      historical_selfie_image_id: image_id
    }

    send_request url, params
  end

  def self.send_request url, params
    params.merge!(api_id: ENV["SENSETIME_API_ID"], api_secret: ENV["SENSETIME_API_SECRET"])
    Rails.logger.debug "  Request #{url} with #{params}."
    result = RestClient.post(url, params)
    Rails.logger.debug "  Response: #{result}"
    JSON.parse result
  end
end
