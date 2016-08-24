class News < ApplicationRecord
  CATEGORIES = {
    '社保政策' => 'policies',
    '社保通知' => 'notifications',
    '社保服务' => 'services'
  }

  has_attached_file :thumbnail_image, styles: { thumb: "100x80>" }
  validates_attachment_content_type :thumbnail_image, content_type: /\Aimage\/.*\Z/

  def thumbnail(request)
    if thumbnail_url.present?
      thumbnail_url
    elsif thumbnail_image.present?
      "#{request.scheme}://#{request.host_with_port}#{thumbnail_image.url}"
    end
  end

  def source(request)
    if source_url.present?
      source_url
    elsif source_content.present?
      "#{request.scheme}://#{request.host_with_port}/news/#{id}"
    end
  end
end
