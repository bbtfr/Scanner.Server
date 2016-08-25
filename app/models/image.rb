class Image < ApplicationRecord
  has_attached_file :file
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  def url(request)
    "#{request.scheme}://#{request.host_with_port}#{file.url}"
  end
end
