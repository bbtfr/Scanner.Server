class Api::IdentitiesController < Api::ApplicationController
  before_action :assign_unique_id, :find_ability

  CONFIDENCE_THRESHOLD = 0.6

  def identify
    # 检查接口使用次数
    unless @ability.has_ability? "liveness_test"
      logger.debug "  UID #{@unique_id} use count limit exceed: :liveness_test"
      json_failed :ok, "接口使用超过限制次数"
      return
    end

    person = Person.where(
      id_number: params["id"],
      name: params["name"]
    ).first

    result = if person
        # 调用人脸比对接口
        SensetimeAPI.historical_selfie_verification person.image, params["image"]
      else
        # 调用公安身份证照片比对接口
        SensetimeAPI.selfie_idnumber_verification params["image"], params["id"], params["name"]
      end

    # 扣除使用次数
    @ability.decrease_use_count! "liveness_test"

    # 保存审计信息
    image = IdentifyImage.create!(
      file: params["image"],
      sensetime_image_id: result["selfie"]["image_id"]
    )

    calling = IdentifyCalling.new(
      request_id: request.request_id,
      remote_ip: request.remote_ip,
      device_id: params["device_id"],
      city_id: params["city_id"],
      endpoint: person ? 'historical_selfie_verification' : 'selfie_idnumber_verification',
      id_number: params["id"],
      name: params["name"],
      image: image,
      sensetime_result: result
    )

    # 打印比对结果
    unless person || result["identity"]["validity"]
      calling.validity = result["identity"]["reason"].parameterize(separator: '_')
      calling.save!

      json_failed :ok, "身份证信息验证失败\n姓名和身份证号不匹配\n请检查您输入的身份信息是否有误\n如有问题，请联系：123456789"
      return
    end

    if result["confidence"] < CONFIDENCE_THRESHOLD
      calling.validity = "ineligible_confidence"
      calling.save!

      json_failed :ok, "脸谱信息验证失败\n请在光线明亮的环境下重新尝试认证\n如有问题，请联系：123456789"
      return
    end

    # 保存验证人员信息
    person ||= Person.new(
      id_number: params["id"],
      name: params["name"]
    )
    person.image = image
    person.save!

    calling.validity = "accepted"
    calling.save!

    # 打印比对结果
    json_success validity: true, message: "检测成功！\n感谢使用，认证结果已发送社保局"
  rescue => error
    logger.error error.message
    json_failed :internal_server_error, "服务器正在维护中，请稍后再试\n如有问题，请联系：123456789"
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
