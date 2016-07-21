class News < ApplicationRecord
  CATEGORIES = {
    '社保政策' => 'policies',
    '社保通知' => 'notifications',
    '社保服务' => 'services'
  }

  has_attached_file :thumbnail_image, styles: { thumb: "100x80>" }
  validates_attachment_content_type :thumbnail_image, content_type: /\Aimage\/.*\Z/

  def thumbnail(request)
    thumbnail_url || "#{request.scheme}://#{request.host_with_port}#{thumbnail_image.url}"
  end

  def source(request)
    source_url || "#{request.scheme}://#{request.host_with_port}/news/#{id}"
  end
end
