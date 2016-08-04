class AndroidPackage < ApplicationRecord
  has_attached_file :file, use_timestamp: false
  validates_attachment_content_type :file, content_type: /\A.*\Z/
end
