class Editormd::ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    image = Image.new(file: params["editormd-image-file"])
    if image.save
      render json: { success: 1, message: "图片上传成功", url: image.url(request) }
    else
      render json: { success: 0, message: image.errors.full_messages.join("；") }
    end
  end
end
