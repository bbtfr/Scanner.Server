class IdentifyCalling < ApplicationRecord
  ENDPOINTS = {
    '公安身份证照片比对接口' => 'selfie_idnumber_verification',
    '人脸比对接口' => 'historical_selfie_verification'
  }

  VALIDITIES = {
    '检验成功' => 'accepted',
    '脸谱信息验证失败' => 'ineligible_confidence',
    '身份证信息验证失败' => 'invalid_idcard_number'
  }

  serialize :sensetime_result, Hash
  belongs_to :image
end
