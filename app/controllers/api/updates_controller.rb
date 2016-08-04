class Api::UpdatesController < ApplicationController
  def show
    package = AndroidPackage.order(version: :desc).first
    version = package && package.version || ""
    if params[:version] < version
      render json: {
        status: :success,
        update: true,
        version: package.version,
        download_url: "#{request.protocol}#{request.host_with_port}#{package.file.url}"
      }
    else
      render json: { status: :success, update: false }
    end
  end
end
