class Upload < ApplicationRecord
  has_attached_file :file
  validates_attachment :file, presence: true,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png", "application/pdf"] },
    size: { in: 0..10.megabytes }
end
