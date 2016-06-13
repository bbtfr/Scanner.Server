require 'rest-client'
require 'dotenv'
Dotenv.load

module SensetimeAPI
  def selfie_idnumber_verification file, id, name
    url = 'https://v1-auth-api.visioncloudapi.com/identity/selfie_idnumber_verification'
    params = {
      selfie_file: file,
      api_id: ENV["API_ID"],
      api_secret: ENV["API_SECRET"],
      id_number: id,
      name: name
    }
    puts "  Request #{url} with #{params}."
    result = RestClient.post(url, params)
    puts "  Response: #{result}"
    JSON.parse result
  rescue Exception => e
    puts e.message
  end
end
