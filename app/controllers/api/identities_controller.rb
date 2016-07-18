class Api::IdentitiesController < Api::ApplicationController
  before_action :assign_unique_id, :find_ability

  CONFIDENCE_THRESHOLD = 0.6

  def identify
    unless @ability.has_ability? "liveness_test"
      logger.debug "  UID #{@unique_id} use count limit exceed: :liveness_test"
      json_failed :ok, "接口使用超过限制次数"
      return
    end

    result = SensetimeAPI.selfie_idnumber_verification params["image"], params["id"], params["name"]

    @ability.decrease_use_count! "liveness_test"

    unless result["identity"]["validity"]
      json_failed :ok, "身份证信息验证失败"
      return
    end

    if result["confidence"] < CONFIDENCE_THRESHOLD
      json_failed :ok, "脸谱信息验证失败"
      return
    end

    json_success validity: true, message: "检测成功"
  rescue => error
    logger.error error.message
    json_failed :internal_server_error, "服务器内部错误"
  end

  def abilities
    abilities = @ability.abilities
    logger.debug "  UID #{@unique_id} abilities: #{abilities}."
    json_success abilities: abilities
  end

  def use_count
    feature = params["feature"]
    if @ability.has_ability? feature
      @ability.decrease_use_count! feature
      json_success
    else
      json_failed :ok, "接口使用超过限制次数"
    end
  rescue => error
    logger.error error.message
    json_failed :internal_server_error, "服务器内部错误"
  end

private

  def assign_unique_id
    @unique_id = params["unique_id"]
    json_failed :bad_request, "请求参数错误" unless @unique_id
  end

  def find_ability
    @ability = Ability.find_or_initialize_by(unique_id: @unique_id)
  end

  def json_failed code, message
    render json: { status: :failed, message: message }, status: status
  end

  def json_success data = {}
    render json: { status: :success }.merge(data)
  end
end
