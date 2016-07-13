defmodule Scanner.API.IdentityController do
  require Logger

  use Scanner.Web, :controller
  use Scanner.JSONHelper

  alias Scanner.Ability
  alias Scanner.SensetimeAPI

  plug :assign_unique_id
  plug :find_ability
  # plug :check_ability, "liveness_test" when action == :identify

  @confidence_threshold 0.60

  def identify conn, params do
    case SensetimeAPI.selfie_idnumber_verification params["image"], params["id"], params["name"] do
      {:ok, result} ->
        # update_ability conn

        if result["identity"]["validity"] do
          if result["confidence"] > @confidence_threshold do
            json_success conn, %{validity: true}
          else
            json_failed conn, 200, "脸谱信息验证失败"
          end
        else
          json_failed conn, 200, "身份证信息验证失败"
        end
      {:error, _reason} -> json_failed conn, 500, "服务器内部错误"
    end
  end

  def abilities conn, _params do
    abilities = Ability.abilities(conn.assigns.ability)
    Logger.debug "UID #{conn.assigns.unique_id} abilities: #{inspect(abilities)}."
    json_success conn, %{abilities: abilities}
  end

  defp check_ability conn, feature do
    ability = conn.assigns.ability
    if Ability.has_ability? ability, feature do
      ability = Ability.decrease_use_count ability, feature
      assign conn, :ability, ability
    else
      Logger.debug "UID #{conn.assigns.unique_id} reach limit: #{feature}"
      json_failed conn, 200, "接口使用超过限制次数"
    end
  end

  defp update_ability conn do
    {:ok, ability} = Repo.update(conn.assigns.ability)
    assign conn, :ability, ability
  end

  defp assign_unique_id conn, _options do
    if unique_id = conn.params["unique_id"] do
      assign conn, :unique_id, unique_id
    else
      json_failed conn, 400, "请求参数错误"
    end
  end

  defp find_ability conn, _options do
    {:ok, _, ability} = Repo.get_by_or_insert(Ability, %{unique_id: conn.assigns.unique_id})
    assign conn, :ability, ability
  end
end
