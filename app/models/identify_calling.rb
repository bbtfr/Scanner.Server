class IdentifyCalling < ApplicationRecord
  ENDPOINTS = {
    '公安身份证照片比对接口' => 'selfie_idnumber_verification',
    '人脸比对接口' => 'historical_selfie_verification'
  }

  serialize :sensetime_result, Hash
  belongs_to :image
end
