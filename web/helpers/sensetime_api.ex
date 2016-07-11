defmodule Scanner.SensetimeAPI do
  require Logger

  @api_id     System.get_env("API_ID")
  @api_secret System.get_env("API_SECRET")

  def selfie_idnumber_verification file, id, name do
    url = "https://v1-auth-api.visioncloudapi.com/identity/selfie_idnumber_verification"
    body = {:multipart, [
      {:file, file.path, {"form-data", [{"name", "selfie_file"}, {"filename", file.filename}]}, [{"Content-Type", file.content_type}]},
      {"api_id", @api_id},
      {"api_secret", @api_secret},
      {"id_number", id},
      {"name", name},
    ]}

    Logger.debug "Request #{url} with #{inspect(body)}"

    result =
      case HTTPoison.post(url, body) do
        {:ok, response} -> Poison.decode response.body
        {:error, reason} -> {:error, reason}
      end

    Logger.debug "Response #{inspect(result)}"

    result
  end
end
